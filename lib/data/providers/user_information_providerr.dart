import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/rent/rental_record_model.dart';

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
          appUser: null,
          rentalRecords: [],
          appData: null,
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
          appUser: null,
          rentalRecords: [],
          appData: null,
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
            appUser: null,
            rentalRecords: [],
            appData: null,
          );
        }

        final requestId = ++_requestId;

        Future.microtask(() => _fetchAllUserData(currentUser.uid, requestId));

        return UserInformation(
          properties: [],
          tenants: [],
          units: [],
          finances: [],
          isLoading: true,
          appUser: null,
          rentalRecords: [],
          appData: null,
        );
      },
    );
  }

  // Future<void> _fetchAllUserData(String userId, int requestId) async {
  //   try {
  //     final dbPropertyService = ref.read(dbPropertyServiceProvider);
  //     final dbTenantService = ref.read(dbTenantServiceProvider);
  //     final dbUnitService = ref.read(dbUnitServiceProvider);
  //     final dbFinancesService = ref.read(dbFinancesServiceProvider);
  //     final dbAppUserService = ref.read(dbServiceProvider);

  //     // ------------------------------------------
  //     // 1. Get user's main data
  //     // ------------------------------------------

  //     final results = await Future.wait([
  //       dbPropertyService.getUserProperties(userId),
  //       dbTenantService.getUserTenants(userId),
  //       dbUnitService.getUserUnits(userId),
  //       dbAppUserService.getUserFromCurrentUserId(userId),
  //     ]);

  //     final properties = results[0] as List<Property>;
  //     final tenants = results[1] as List<Tenant>;
  //     final units = results[2] as List<Unit>;
  //     final appUser = results[3] as AppUser?;

  //     // ------------------------------------------
  //     // 2. Synchronize rental histories
  //     // ------------------------------------------

  //     final List<RentHistory> rentalHistories = [];

  //     for (final tenant in tenants) {
  //       final history = await _synchronizeTenantRentalMonths(tenant);

  //       if (history != null) {
  //         rentalHistories.add(history);
  //       }
  //     }

  //     // ------------------------------------------
  //     // 3. Derive ALL rental entries
  //     // ------------------------------------------

  //     final List<RentalRecord> rentalRecords = rentalHistories
  //         .expand(
  //           (history) => history.rentalMonths.expand(
  //             (rentalMonth) => rentalMonth.rentEntries.map(
  //               (rentEntry) => RentalRecord(
  //                 rentEntry: rentEntry,
  //                 rentHistory: history,
  //                 rentalMonth: rentalMonth,
  //                 tenantId: history.tenantId,
  //               ),
  //             ),
  //           ),
  //         )
  //         .toList();

  //     // ------------------------------------------
  //     // 4. Get finances AFTER rental synchronization
  //     // ------------------------------------------

  //     final finances = await dbFinancesService.getFinancialRecords(userId);

  //     // ------------------------------------------
  //     // 5. Check request is still valid
  //     // ------------------------------------------

  //     if (!ref.mounted || requestId != _requestId) {
  //       return;
  //     }

  //     // ------------------------------------------
  //     // 6. Publish everything
  //     // ------------------------------------------

  //     state = UserInformation(
  //       properties: properties,
  //       tenants: tenants,
  //       units: units,
  //       finances: finances,
  //       rentalRecords: rentalRecords,
  //       appUser: appUser,
  //       isLoading: false,
  //     );
  //   } catch (e, stackTrace) {
  //     log('Error bundling user information: $e', stackTrace: stackTrace);

  //     if (!ref.mounted || requestId != _requestId) {
  //       return;
  //     }

  //     state = state.copyWith(isLoading: false);
  //   }
  // }
  Future<void> _fetchAllUserData(String userId, int requestId) async {
    try {
      final dbPropertyService = ref.read(dbPropertyServiceProvider);
      final dbTenantService = ref.read(dbTenantServiceProvider);
      final dbUnitService = ref.read(dbUnitServiceProvider);
      final dbFinancesService = ref.read(dbFinancesServiceProvider);
      final dbAppUserService = ref.read(dbServiceProvider);

      // 1. Fetch properties, tenants and units
      final results = await Future.wait([
        dbPropertyService.getUserProperties(userId),
        dbTenantService.getUserTenants(userId),
        dbUnitService.getUserUnits(userId),
        dbAppUserService.getUserFromCurrentUserId(userId),
      ]);

      final properties = results[0] as List<Property>;
      final tenants = results[1] as List<Tenant>;
      final units = results[2] as List<Unit>;
      final appUser = results[3] as AppUser?;
      List<RentHistory> rentalHistories = [];

      for (final tenant in tenants) {
        final history = await _synchronizeTenantRentalMonths(tenant);

        if (history != null) {
          rentalHistories.add(history);
        }
      }
      log('All rent histories  : ${rentalHistories.length}');
      // ------------------------------------------
      // 3. Derive ALL rental entries
      // ------------------------------------------

      final rentalRecords = rentalHistories
          .expand(
            (history) => history.rentalMonths.expand(
              (rentalMonth) => rentalMonth.rentEntries.map(
                (rentEntry) => RentalRecord(
                  rentEntry: rentEntry,
                  rentHistory: history,
                  rentalMonth: rentalMonth,
                  tenantId: history.tenantId,
                  unitId: history.unitId,
                ),
              ),
            ),
          )
          .toList();
      log('All rent records  : ${rentalRecords.length}');
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
        appUser: appUser,
        appData: AppData(
          properties: properties,
          tenants: tenants,
          activeTenants: tenants
              .where((tenant) => tenant.endOfLease != null)
              .toList(),
          rentRecords: rentalRecords,
          finances: finances,
          appUser: appUser,
          units: units,
        ),
        rentalRecords: rentalRecords,
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
          RentalMonth(
            rentalMonth: monthName,
            unitRent: tenant.unitRent,
            rentEntries: const [],
          ),
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
    state = state.copyWith(
      tenants: [...state.tenants, newTenant],
      appData: state.appData?.copyWith(
        tenants: [...state.appData?.tenants ?? [], newTenant],
      ),

      // appData: [...tenants: state.appData?.tenants, newTenant],
    );
  }

  void appendUnit(Unit newUnit) {
    state = state.copyWith(
      units: [...state.units, newUnit],
      appData: state.appData?.copyWith(
        units: [...state.appData?.units ?? [], newUnit],
      ),
    );
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
