import 'package:anyamar/commons/exports.dart';

final userInformationProvider =
    NotifierProvider<UserInformationNotifier, UserInformation>(() {
      return UserInformationNotifier();
    });

class UserInformationNotifier extends Notifier<UserInformation> {
  int _requestId = 0;

  // ============================================================
  // BUILD
  // ============================================================

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
          rentalRecords: [],
          appUser: null,
          isLoading: true,
          appData: null,
        );
      },

      error: (error, stackTrace) {
        log('Auth state error: $error', stackTrace: stackTrace);

        return UserInformation(
          properties: [],
          tenants: [],
          units: [],
          finances: [],
          rentalRecords: [],
          appUser: null,
          isLoading: false,
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
            rentalRecords: [],
            appUser: null,
            isLoading: false,
            appData: null,
          );
        }

        final requestId = ++_requestId;

        // IMPORTANT:
        // Do not perform async work directly inside build().
        Future.microtask(() => _fetchAllUserData(currentUser.uid, requestId));

        return UserInformation(
          properties: [],
          tenants: [],
          units: [],
          finances: [],
          rentalRecords: [],
          appUser: null,
          isLoading: true,
        );
      },
    );
  }

  // ============================================================
  // FETCH ALL USER DATA
  // ============================================================

  Future<void> _fetchAllUserData(String userId, int requestId) async {
    try {
      final dbPropertyService = ref.read(dbPropertyServiceProvider);

      final dbTenantService = ref.read(dbTenantServiceProvider);

      final dbUnitService = ref.read(dbUnitServiceProvider);

      final dbFinancesService = ref.read(dbFinancesServiceProvider);

      final dbAppUserService = ref.read(dbServiceProvider);

      // --------------------------------------------------------
      // 1. Fetch basic user data
      // --------------------------------------------------------

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

      log('Properties fetched: ${properties.length}');

      log('Tenants fetched: ${tenants.length}');

      log('Units fetched: ${units.length}');

      log('App user: ${appUser?.userEmail}');

      // --------------------------------------------------------
      // 2. Synchronize every tenant's rental history
      // --------------------------------------------------------

      final List<RentHistory> rentalHistories = [];

      for (final tenant in tenants) {
        if (tenant.tenantId == null) {
          log(
            'Skipping tenant without tenantId: '
            '${tenant.tenantName}',
          );

          continue;
        }

        final history = await _synchronizeTenantRentalMonths(tenant);

        if (history != null) {
          rentalHistories.add(history);

          log(
            'History loaded for ${tenant.tenantName}: '
            '${history.rentalMonths.length} months',
          );

          // Debug every month's entries
          for (final month in history.rentalMonths) {
            log(
              '  ${month.rentalMonth}: '
              '${month.rentEntries.length} entries',
            );
          }
        }
      }

      log(
        'All rent histories: '
        '${rentalHistories.length}',
      );

      // --------------------------------------------------------
      // 3. Flatten all rent entries
      // --------------------------------------------------------

      final List<RentalRecord> rentalRecords = rentalHistories
          .expand(
            (history) => history.rentalMonths.expand(
              (rentalMonth) => rentalMonth.rentEntries.map((rentEntry) {
                log(
                  'Creating RentalRecord: '
                  '${rentEntry.rentEntryId} '
                  '| ${rentalMonth.rentalMonth}',
                );

                return RentalRecord(
                  rentEntry: rentEntry,
                  rentHistory: history,
                  rentalMonth: rentalMonth,
                  tenantId: history.tenantId,
                  unitId: history.unitId,
                );
              }),
            ),
          )
          .toList();

      log(
        'All rental records: '
        '${rentalRecords.length}',
      );

      // --------------------------------------------------------
      // 4. Fetch finances
      //
      // Do this AFTER rental history synchronization.
      // --------------------------------------------------------

      final finances = await dbFinancesService.getFinancialRecords(userId);

      log(
        'Financial records: '
        '${finances.length}',
      );

      // --------------------------------------------------------
      // 5. Check that this request is still valid
      // --------------------------------------------------------

      if (!ref.mounted) {
        log('UserInformationNotifier is no longer mounted.');

        return;
      }

      if (requestId != _requestId) {
        log('Ignoring stale user data request.');

        return;
      }

      /// --------------------------------------------------------
      /// 6. Instance of AppData
      /// -------------------------------------------------------
      AppData appData = AppData(
        properties: properties,
        tenants: tenants,
        finances: finances,
        units: units,
        appUser: appUser,
        rentRecords: rentalRecords,
      );

      // --------------------------------------------------------
      // 7. Publish EVERYTHING at once
      // --------------------------------------------------------

      state = UserInformation(
        properties: properties,
        tenants: tenants,
        units: units,
        finances: finances,
        rentalRecords: rentalRecords,
        appUser: appUser,
        appData: appData,
        isLoading: false,
      );

      log('UserInformation successfully initialized.');
    } catch (e, stackTrace) {
      log('Error bundling user information: $e', stackTrace: stackTrace);

      if (!ref.mounted) {
        return;
      }

      if (requestId != _requestId) {
        return;
      }

      state = state.copyWith(isLoading: false);
    }
  }

  // ============================================================
  // RENTAL HISTORY SYNCHRONIZATION
  // ============================================================

  Future<RentHistory?> _synchronizeTenantRentalMonths(Tenant tenant) async {
    final tenantId = tenant.tenantId;

    if (tenantId == null) {
      return null;
    }

    final rentalDb = DbRentalService();

    // ----------------------------------------------------------
    // 1. Get existing history
    // ----------------------------------------------------------

    RentHistory? history = await rentalDb.getRentHistory(tenantId);

    // ----------------------------------------------------------
    // 2. Create history if it doesn't exist
    // ----------------------------------------------------------

    if (history == null) {
      log(
        'No rent history found for '
        '${tenant.tenantName}. Creating one...',
      );

      history = RentHistory(
        tenantId: tenantId,
        unitId: tenant.unitId,
        userId: tenant.userId,
        tenantName: tenant.tenantName,
        rentalMonths: [],
      );

      history = await rentalDb.addRentHistory(history);

      if (history == null) {
        log(
          'Failed to create rent history for '
          '${tenant.tenantName}',
        );

        return null;
      }
    }

    // ----------------------------------------------------------
    // 3. Generate required months
    // ----------------------------------------------------------

    final requiredMonths = _generateRequiredMonths(
      tenant.startOfLease,
      DateTime.now(),
    );

    // ----------------------------------------------------------
    // 4. Get existing month names
    // ----------------------------------------------------------

    final existingMonthNames = history.rentalMonths
        .map((month) => month.rentalMonth)
        .toSet();

    // ----------------------------------------------------------
    // 5. Copy existing months
    // ----------------------------------------------------------

    final updatedMonths = [...history.rentalMonths];

    bool changed = false;

    // ----------------------------------------------------------
    // 6. Add missing months
    // ----------------------------------------------------------

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
          'Added rental month $monthName '
          'for ${tenant.tenantName}',
        );
      }
    }

    // ----------------------------------------------------------
    // 7. Persist only if something changed
    // ----------------------------------------------------------

    if (changed) {
      final updatedHistory = history.copyWith(rentalMonths: updatedMonths);

      await rentalDb.updateRentHistory(updatedHistory);

      // IMPORTANT:
      // Return the updated object.
      //
      // The existing rentEntries are still present because
      // updatedMonths was copied from history.rentalMonths.

      history = updatedHistory;
    }

    return history;
  }

  // ============================================================
  // GENERATE REQUIRED MONTHS
  // ============================================================

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

  // ============================================================
  // FORMAT RENTAL MONTH
  // ============================================================

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

  // ============================================================
  // LOCAL MUTATIONS
  // ============================================================

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
        return unit.unitId == updatedUnit.unitId ? updatedUnit : unit;
      }).toList(),
    );
  }

  void updateTenant(Tenant updatedTenant) {
    state = state.copyWith(
      tenants: state.tenants.map((tenant) {
        return tenant.tenantId == updatedTenant.tenantId
            ? updatedTenant
            : tenant;
      }).toList(),
    );
  }

  void updateProperty(Property updatedProperty) {
    state = state.copyWith(
      properties: state.properties.map((property) {
        return property.propertyId == updatedProperty.propertyId
            ? updatedProperty
            : property;
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
          .where((tenant) => tenant.tenantId != tenantId)
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
