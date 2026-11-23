import 'package:anyamar/commons/exports.dart';

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
          activeTenants: [],
          rentalHistories: [],
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
          activeTenants: [],
          rentalHistories: [],
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
            activeTenants: [],
            rentalHistories: [],
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
          activeTenants: [],
          rentalHistories: [],
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
        final history = await synchronizeTenantRentalMonths(tenant);

        if (history != null) {
          rentalHistories.add(history);
        }
      }

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
                  propertyId: rentEntry.propertyId ?? '',
                ),
              ),
            ),
          )
          .toList();

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
        activeTenants: tenants
            .where((tenant) => tenant.isActive == true)
            .toList(),
        rentalRecords: rentalRecords,
        rentalHistories: rentalHistories,
      );
    } catch (e, stackTrace) {
      log('Error bundling userInformation data: $e', stackTrace: stackTrace);

      if (!ref.mounted || requestId != _requestId) {
        return;
      }

      state = state.copyWith(isLoading: false);
    }
  }

  //! ==========================================================
  //! RENTAL MONTH SYNCHRONIZATION
  //! ==========================================================

  Future<RentHistory?> synchronizeTenantRentalMonths(Tenant tenant) async {
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
        tenantName: tenant.tenantName,
      );

      history = await rentalDb.addRentHistory(history);

      if (history == null) {
        return null;
      }
    }

    // --------------------------------------------------
    // 3. Determine the rental period
    // --------------------------------------------------

    final now = DateTime.now();

    // Do not generate rental months beyond the lease end date.
    final generationEndDate =
        tenant.endOfLease != null && tenant.endOfLease!.isBefore(now)
        ? tenant.endOfLease!
        : now;

    final requiredMonths = generateRequiredMonths(
      tenant.startOfLease,
      generationEndDate,
    );

    // --------------------------------------------------
    // 4. Find existing months
    // --------------------------------------------------

    final existingMonthNames = history.rentalMonths
        .map((month) => month.rentalMonth)
        .toSet();

    // --------------------------------------------------
    // 5. Prepare existing months for updates
    // --------------------------------------------------

    final updatedMonths = [...history.rentalMonths];

    bool changed = false;

    // --------------------------------------------------
    // 6. Update current month's charges when appropriate
    // --------------------------------------------------

    final currentMonthName = '${_monthName(now.month)}/${now.year}';

    final currentMonthIndex = updatedMonths.indexWhere(
      (month) => month.rentalMonth == currentMonthName,
    );

    if (currentMonthIndex != -1) {
      final currentMonth = updatedMonths[currentMonthIndex];

      // Only update current month's charges if no payment
      // has been recorded for that month.
      if (currentMonth.rentEntries.isEmpty) {
        final currentCharges = currentMonth.unitRent;
        final newCharges = tenant.unitRent;

        if (currentCharges != newCharges) {
          updatedMonths[currentMonthIndex] = currentMonth.copyWith(
            unitRent: newCharges,
            paymentIsCompleted: false,
          );

          changed = true;

          log(
            'Updated charges for $currentMonthName '
            'for tenant ${tenant.tenantName}.',
          );
        }
      }
    }

    // --------------------------------------------------
    // 7. Add missing rental months
    // --------------------------------------------------

    for (final monthName in requiredMonths) {
      if (!existingMonthNames.contains(monthName)) {
        updatedMonths.add(
          RentalMonth(
            rentalMonth: monthName,
            unitRent: tenant.unitRent,
            rentEntries: const [],
            paymentIsCompleted: false,
          ),
        );

        // Keep the set updated to prevent duplicate additions.
        existingMonthNames.add(monthName);

        changed = true;

        log(
          'Added $monthName to tenant '
          '${tenant.tenantName}',
        );
      }
    }

    // --------------------------------------------------
    // 8. Nothing changed
    // --------------------------------------------------

    if (!changed) {
      return history;
    }

    // --------------------------------------------------
    // 9. Save updated history
    // --------------------------------------------------

    final updatedHistory = history.copyWith(rentalMonths: updatedMonths);

    await rentalDb.updateRentHistory(updatedHistory);

    return updatedHistory;
  }

  //? ==========================================================
  //? GENERATE MONTHS
  //? ==========================================================

  List<String> generateRequiredMonths(DateTime leaseStart, DateTime now) {
    final List<String> months = [];

    DateTime current = DateTime(leaseStart.year, leaseStart.month);

    final DateTime end = DateTime(now.year, now.month);

    while (!current.isAfter(end) || current.isAtSameMomentAs(end)) {
      months.add(formatRentalMonth(current));

      current = DateTime(current.year, current.month + 1);
    }

    return months;
  }

  String formatRentalMonth(DateTime date) {
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
  Future<void> appendProperty(Property newProperty) async {
    state = state.copyWith(properties: [...state.properties, newProperty]);
  }

  void appendTenant(Tenant newTenant) {
    state = state.copyWith(tenants: [...state.tenants, newTenant]);
  }

  void appendRentHistory(RentHistory newHistory) {
    //todo: To add a rental record or not ?? that's the question

    state = state.copyWith(
      rentalHistories: [...state.rentalHistories, newHistory],
    );
  }

  void appendUnit(Unit newUnit) {
    state = state.copyWith(units: [...state.units, newUnit]);
  }

  Future<void> appendFinances(FinancialRecord newRecord) async {
    state = state.copyWith(finances: [...state.finances, newRecord]);
  }

  Future<void> appendRentRecords(RentalRecord newRecord) async {
    state = state.copyWith(rentalRecords: [...state.rentalRecords, newRecord]);
  }

  Future<void> updateFinance(FinancialRecord updatedRecord) async {
    state = state.copyWith(
      finances: [
        for (final financialRecord in state.finances)
          if (financialRecord.recordId == updatedRecord.recordId)
            updatedRecord
          else
            financialRecord,
      ],
    );
  }

  Future<void> updateUnit(Unit updatedUnit) async {
    state = state.copyWith(
      units: [
        for (final unit in state.units)
          if (unit.unitId == updatedUnit.unitId) updatedUnit else unit,
      ],
    );
  }

  Future<void> updateTenant(Tenant updatedTenant) async {
    state = state.copyWith(
      tenants: [
        for (final tenant in state.tenants)
          if (tenant.tenantId == updatedTenant.tenantId)
            updatedTenant
          else
            tenant,
      ],
    );
  }

  Future<void> updateRentalHistory(RentHistory updatedHistory) async {
    state = state.copyWith(
      rentalHistories: [
        for (final history in state.rentalHistories)
          if (updatedHistory.historyId == history.historyId)
            updatedHistory
          else
            history,
      ],
    );
  }

  Future<void> updateProperty(Property updatedProperty) async {
    state = state.copyWith(
      properties: [
        for (final property in state.properties)
          if (property.propertyId == updatedProperty.propertyId)
            updatedProperty
          else
            property,
      ],
    );
  }

  Future<void> updateUser(AppUser updatedAppUser) async {
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
  //!=============================
  //! UNIT RELATED METHODS
  //!==============================

  //*Generate list of floor Numbers
  List<String> generatePropertyFloorNumbers(Property selectedP) {
    return [
      'Ground Floor',
      ...List.generate(
        selectedP.propertyFloors.toInt(),
        (index) => '${index + 1} Floor',
      ),
    ];
  }

  //*Convert a unit's floor number to String
  String convertFloorNumberToString(double floorNumber) {
    if (floorNumber == 0) {
      return 'Ground Floor';
    }

    return '${floorNumber.toInt()} Floor';
  }

  //* Convert a units floor string to Number
  double? convertFloorStringToNumber(String floor) {
    if (floor.isEmpty) return null;

    if (floor == 'Ground Floor') return 0;

    final match = RegExp(r'^(\d+) Floor$').firstMatch(floor);

    return match != null ? double.tryParse(match.group(1)!) : null;
  }

  //*=====================================================================================
  //*RENT RELATED METHODS
  //*====================================================================================
  //? Calculate all rent entries in a month
  double calculateRentalMonthRentalRecords(RentalMonth rentalMonth) {
    return rentalMonth.rentEntries.fold<double>(
      0.0,
      (total, entry) => total + entry.amountPaid,
    );
  }

  //? Calculate utilities charge
  double calculateUtilitiesCharge(Rent? rent) {
    if (rent == null) return 0.0;

    final utilitiesTotal =
        rent.utilities?.fold<double>(
          0.0,
          (total, utility) => total + utility.amountPayable,
        ) ??
        0.0;
    return utilitiesTotal;
  }

  //? Calculate amount payable monthly
  double calculateMonthlyAmountPayable(Rent? rent) {
    if (rent == null) return 0.0;

    final utilitiesTotal =
        rent.utilities?.fold<double>(
          0.0,
          (total, utility) => total + utility.amountPayable,
        ) ??
        0.0;

    return rent.rentAmount + utilitiesTotal;
  }

  //?Total expenses
  double calculateTotalExpenses(List<FinancialRecord> expenses) {
    return expenses.fold<double>(0, (sum, record) => sum + record.amountPaid);
  }

  //? Get actual amount paid for a specific month
  double calculateMonthlyAmountPaid(RentalMonth month) {
    return month.rentEntries.fold<double>(
      0.0,
      (total, entry) => total + entry.amountPaid,
    );
  }

  //? Get outstanding balance
  double calculateMonthlyOutstandingPayment(RentalMonth month) {
    return calculateMonthlyAmountPayable(month.unitRent) -
        calculateMonthlyAmountPaid(month);
  }

  //? Get overPayment
  double calculateMonthlyOverPayment(RentalMonth month) {
    return calculateMonthlyAmountPaid(month) -
        calculateMonthlyAmountPayable(month.unitRent);
  }

  //? Update an individual's monthly rental obligation
  Future<void> updateMonthlyCharges({
    required String tenantId,
    required String rentalMonthName,
    required Rent updatedRent,
  }) async {
    try {
      // 1. Find the tenant's rental history.
      final historyIndex = state.rentalHistories.indexWhere(
        (history) => history.tenantId == tenantId,
      );

      if (historyIndex == -1) {
        log('No rental history found for tenant: $tenantId');
        return;
      }

      final history = state.rentalHistories[historyIndex];

      // 2. Find the specified rental month.
      final monthIndex = history.rentalMonths.indexWhere(
        (month) => month.rentalMonth == rentalMonthName,
      );

      if (monthIndex == -1) {
        log('Rental month not found: $rentalMonthName');
        return;
      }

      // 3. Update only the selected month's charges.
      final updatedMonths = [...history.rentalMonths];

      updatedMonths[monthIndex] = updatedMonths[monthIndex].copyWith(
        unitRent: updatedRent,
        paymentIsCompleted:
            calculateMonthlyAmountPaid(updatedMonths[monthIndex]) >=
            calculateMonthlyAmountPayable(updatedRent),
      );

      // 4. Create the updated rental history.
      final updatedHistory = history.copyWith(rentalMonths: updatedMonths);

      // 5. Persist the updated history.
      await DbRentalService().updateRentHistory(updatedHistory);

      // 6. Update the global rental histories.
      final updatedHistories = [...state.rentalHistories];

      updatedHistories[historyIndex] = updatedHistory;

      // 7. Rebuild flattened rental records.
      final updatedRentalRecords = updatedHistories
          .expand(
            (history) => history.rentalMonths.expand(
              (month) => month.rentEntries.map(
                (entry) => RentalRecord(
                  tenantId: history.tenantId,
                  unitId: history.unitId,
                  rentEntry: entry,
                  rentalMonth: month,
                  rentHistory: history,
                  propertyId: entry.propertyId ?? '',
                ),
              ),
            ),
          )
          .toList();

      // 8. Publish the updated global state.
      state = state.copyWith(
        rentalHistories: updatedHistories,
        rentalRecords: updatedRentalRecords,
      );

      log(
        'Successfully updated charges for '
        '$tenantId - $rentalMonthName',
      );
    } catch (e, stackTrace) {
      log('Error updating monthly rental charges: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  String _monthName(int month) {
    const months = [
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

    return months[month - 1];
  }
}
