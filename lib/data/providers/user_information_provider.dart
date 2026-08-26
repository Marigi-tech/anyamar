import 'dart:developer';
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/models/user_information/user_information_model.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/data/services/db_finances_service.dart';
import 'package:anyamar/data/services/db_property_service.dart';
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

      final results = await Future.wait([
        dbPropertyService.getUserProperties(userId),
        dbTenantService.getUserTenants(userId),
        dbUnitService.getUserUnits(userId),
        dbFinancesService.getFinancialRecords(userId),
      ]);

      if (!ref.mounted || requestId != _requestId) {
        return;
      }

      state = UserInformation(
        properties: results[0] as List<Property>,
        tenants: results[1] as List<Tenant>,
        units: results[2] as List<Unit>,
        finances: results[3] as List<FinancialRecord>,
        isLoading: false,
      );
    } catch (e) {
      log('Error bundling userInformation data: $e');

      if (!ref.mounted || requestId != _requestId) {
        return;
      }

      state = state.copyWith(isLoading: false);
    }
  }

  // Local mutate functions are now clean and isolated
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
}
