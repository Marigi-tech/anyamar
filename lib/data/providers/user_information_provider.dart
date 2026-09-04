import 'dart:developer';
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/rent/rent_history_model.dart';
import 'package:anyamar/data/models/rent/rental_month/rental_month_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/models/user_information/user_information_model.dart';
import 'package:anyamar/data/models/users/app_user.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/data/services/db_finances_service.dart';
import 'package:anyamar/data/services/db_property_service.dart';
import 'package:anyamar/data/services/db_rental_records.dart';
import 'package:anyamar/data/services/db_tenants_service.dart';
import 'package:anyamar/data/services/db_units_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInformationProvider =
    NotifierProvider<UserInformationNotifier, UserInformation>(() {
      return UserInformationNotifier();
    });

class UserInformationNotifier extends Notifier<UserInformation> {
  int _requestId = 0;

  @override
  UserInformation build() {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      loading: () {
        return UserInformation(
          properties: [],
          tenants: [],
          units: [],
          finances: [],

          isLoading: true,
        );
      },

      error: (error, stackTrace) {
        log('Auth state error: $error');

        return UserInformation(
          properties: [],
          tenants: [],
          units: [],
          finances: [],

          isLoading: false,
        );
      },

      data: (currentUser) {
        if (currentUser == null) {
          return UserInformation(
            properties: [],
            tenants: [],
            units: [],
            finances: [],

            isLoading: false,
          );
        }

        final requestId = ++_requestId;

        Future.microtask(() => _fetchAllUserData(currentUser.uid, requestId));

        return UserInformation(
          properties: [],
          tenants: [],
          units: [],
          finances: [],
          appUser: null,
          isLoading: true,
        );
      },
    );
  }

  Future<void> _fetchAllUserData(String userId, int requestId) async {
    try {
      final dbPropertyService = ref.read(dbPropertyServiceProvider);
      final dbTenantService = ref.read(dbTenantServiceProvider);
      final dbUnitService = ref.read(dbUnitServiceProvider);
      final dbFinancesService = ref.read(dbFinancesServiceProvider);

      // 1. Fetch properties, tenants and units
      final results = await Future.wait([
        dbPropertyService.getUserProperties(userId),
        dbTenantService.getUserTenants(userId),
        dbUnitService.getUserUnits(userId),
      ]);

      final properties = results[0] as List<Property>;
      final tenants = results[1] as List<Tenant>;
      final units = results[2] as List<Unit>;

      // 2. Prepare rental histories/months
      for (final tenant in tenants) {
        await _synchronizeTenantRentalMonths(tenant);
      }

      // 3. NOW get finances
      //
      // getFinancialRecords() reads rent histories,
      // so synchronization must happen first.
      final finances = await dbFinancesService.getFinancialRecords(userId);

      // 4. Make sure this request is still valid
      if (!ref.mounted || requestId != _requestId) {
        return;
      }

      // 5. Publish everything at once
      state = UserInformation(
        properties: properties,
        tenants: tenants,
        units: units,
        finances: finances,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      log('Error bundling userInformation data: $e', stackTrace: stackTrace);

      if (!ref.mounted || requestId != _requestId) {
        return;
      }

      state = state.copyWith(isLoading: false);
    }
  }
  // Future<void> _fetchAllUserData(String userId, int requestId) async {
  //   try {
  //     final dbPropertyService = ref.read(dbPropertyServiceProvider);
  //     final dbTenantService = ref.read(dbTenantServiceProvider);
  //     final dbUnitService = ref.read(dbUnitServiceProvider);
  //     final dbFinancesService = ref.read(dbFinancesServiceProvider);

  //     final results = await Future.wait([
  //       dbPropertyService.getUserProperties(userId),
  //       dbTenantService.getUserTenants(userId),
  //       dbUnitService.getUserUnits(userId),
  //       dbFinancesService.getFinancialRecords(userId),
  //     ]);

  //     if (!ref.mounted || requestId != _requestId) {
  //       return;
  //     }

  //     state = UserInformation(
  //       properties: results[0] as List<Property>,
  //       tenants: results[1] as List<Tenant>,
  //       units: results[2] as List<Unit>,
  //       finances: results[3] as List<FinancialRecord>,
  //       isLoading: false,
  //     );
  //   } catch (e) {
  //     log('Error bundling userInformation data: $e');
  //     if (!ref.mounted || requestId != _requestId) {
  //       return;
  //     }
  //     state = state.copyWith(isLoading: false);
  //   }
  // }
  // ==========================================================
  // RENTAL MONTH SYNCHRONIZATION
  // ==========================================================

  Future<RentHistory?> _synchronizeTenantRentalMonths(Tenant tenant) async {
    final tenantId = tenant.tenantId;
    final rentalDb = DbRentalService();

    if (tenantId == null) {
      return null;
    }

    // --------------------------------------------------
    // 1. Get existing rent history
    // --------------------------------------------------

    RentHistory? history = await rentalDb.getRentHistory(tenantId);

    // --------------------------------------------------
    // 2. If there is no history, create one
    // --------------------------------------------------

    if (history == null) {
      log(
        'No rent history found for ${tenant.tenantName}. '
        'Creating one...',
      );

      history = RentHistory(
        tenantId: tenantId,
        unitId: tenant.unitId,
        userId: tenant.userId,
        
      );

      history = await rentalDb.addRentHistory(history);

      if (history == null) {
        return null;
      }
    }

    // --------------------------------------------------
    // 3. Generate every required month
    // --------------------------------------------------

    final requiredMonths = _generateRequiredMonths(
      tenant.startOfLease,
      DateTime.now(),
    );

    // --------------------------------------------------
    // 4. Find existing months
    // --------------------------------------------------

    final existingMonthNames = history.rentalMonths
        .map((month) => month.rentalMonth)
        .toSet();

    // --------------------------------------------------
    // 5. Add missing months
    // --------------------------------------------------

    final updatedMonths = [...history.rentalMonths];

    bool changed = false;

    for (final monthName in requiredMonths) {
      if (!existingMonthNames.contains(monthName)) {
        updatedMonths.add(
          RentalMonth(rentalMonth: monthName, 
          unitRent: tenant.unitRent,
          rentEntries: const []),
        );

        changed = true;

        log(
          'Added $monthName to tenant '
          '${tenant.tenantName}',
        );
      }
    }

    // --------------------------------------------------
    // 6. Nothing changed
    // --------------------------------------------------

    if (!changed) {
      return history;
    }

    // --------------------------------------------------
    // 7. Save updated history
    // --------------------------------------------------

    final updatedHistory = history.copyWith(rentalMonths: updatedMonths);

    await rentalDb.updateRentHistory(updatedHistory);

    return updatedHistory;
  }

  // ==========================================================
  // GENERATE MONTHS
  // ==========================================================

  List<String> _generateRequiredMonths(DateTime leaseStart, DateTime now) {
    final List<String> months = [];

    DateTime current = DateTime(leaseStart.year, leaseStart.month);

    final DateTime end = DateTime(now.year, now.month);

    while (!current.isAfter(end)) {
      months.add(_formatRentalMonth(current));

      current = DateTime(current.year, current.month + 1);
    }

    return months;
  }

  String _formatRentalMonth(DateTime date) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${monthNames[date.month - 1]}/${date.year}';
  }

  // ==========================================================
  // LOCAL METHODS
  // ==========================================================
  void appendProperty(Property newProperty) {
    state = state.copyWith(properties: [...state.properties, newProperty]);
  }

  void appendTenant(Tenant newTenant) {
    state = state.copyWith(tenants: [...state.tenants, newTenant]);
  }

  void appendUnit(Unit newUnit) {
    state = state.copyWith(units: [...state.units, newUnit]);
  }

  void appendFinances(FinancialRecord newRecord) {
    state = state.copyWith(finances: [...state.finances, newRecord]);
  }

  void updateFinance(FinancialRecord updatedRecord) {
    final updatedFinances = state.finances.map((record) {
      return record.recordId == updatedRecord.recordId ? updatedRecord : record;
    }).toList();

    state = state.copyWith(finances: updatedFinances);
  }

  void updateUnit(Unit updatedUnit) {
    state = state.copyWith(
      units: state.units.map((unit) {
        if (unit.unitId == updatedUnit.unitId) {
          return updatedUnit;
        }

        return unit;
      }).toList(),
    );
  }

  void updateTenant(Tenant updatedTenant) {
    state = state.copyWith(
      tenants: state.tenants.map((tenant) {
        if (tenant.tenantId == updatedTenant.tenantId) {
          return updatedTenant;
        }

        return tenant;
      }).toList(),
    );
  }

  void updateProperty(Property updatedProperty) {
    state = state.copyWith(
      properties: state.properties.map((property) {
        if (property.propertyId == updatedProperty.propertyId) {
          return updatedProperty;
        }

        return property;
      }).toList(),
    );
  }

  void updateUser(AppUser updatedAppUser) {
    state = state.copyWith(appUser: updatedAppUser);
  }

  Future<void> removeFinance(String? recordId) async {
    state = state.copyWith(
      finances: state.finances
          .where((record) => record.recordId != recordId)
          .toList(),
    );
  }

  Future<void> removeTenant(String? tenantId) async {
    state = state.copyWith(
      tenants: state.tenants
          .where((record) => record.tenantId != tenantId)
          .toList(),
    );
  }

  Future<void> removeProperty(String? propertyId) async {
    state = state.copyWith(
      properties: state.properties
          .where((property) => property.propertyId != propertyId)
          .toList(),
    );
  }

  Future<void> removeRentRecord(String? rentRecordId) async {
    state = state.copyWith(
      finances: state.finances
          .where((record) => record.recordId != rentRecordId)
          .toList(),
    );
  }

  Future<void> removeUnit(String? unitId) async {
    state = state.copyWith(
      units: state.units.where((unit) => unit.unitId != unitId).toList(),
    );
  }
}
