// import 'package:anyamar/commons/exports.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'finances_notifier.g.dart';

// @riverpod
// class FinancesPageNotifier extends _$FinancesPageNotifier {
//   final List<FinancesPageState> _history = [];

//   @override
//   FinancesPageState build() {
//     const initialState = FinancesTablePageState();

//     _history.clear();
//     _history.add(initialState);

//     return initialState;
//   }

//   /// Navigate to a new finances page state
//   void goTo(FinancesPageState newState) {
//     _history.add(newState);
//     state = newState;
//   }

//   /// Go back to the previous finances page state
//   void goBack() {
//     // Don't remove the initial page
//     if (_history.length <= 1) {
//       return;
//     }

//     _history.removeLast();
//     state = _history.last;
//   }

//   /// Whether there is a previous page to go back to
//   bool get canGoBack => _history.length > 1;

//   /// Return directly to the main finances table
//   void goToFinancesTable() {
//     _history
//       ..clear()
//       ..add(const FinancesTablePageState());

//     state = const FinancesTablePageState();
//   }

//   // ------------------------------------------------------------
//   // Finances Table
//   // ------------------------------------------------------------

//   void financesTable() {
//     state = const FinancesTablePageState();
//   }

//   // ------------------------------------------------------------
//   // Add Expense record
//   // ------------------------------------------------------------

//   void addExpenseRecord() {
//     state = const AddExpenseFinanceRecordPageState();
//   }
//   // ------------------------------------------------------------
//   // Add Rental Income
//   // ------------------------------------------------------------

//   void addIncomeRecord() {
//     state = const AddIncomeFinanceRecordPageState();
//   }

//   // ------------------------------------------------------------
//   // View Expense Financial Record
//   // ------------------------------------------------------------

//   void viewFinancialRecord(FinancialRecord financialRecord) {
//     state = ViewExpenseFinanceRecordPageState(financialRecord: financialRecord);
//   }
//   // ------------------------------------------------------------
//   // View Rent Entry Record
//   // ------------------------------------------------------------

//   void viewRentEntryRecord(SingleRentEntry financialRecord) {
//     state = ViewRentEntryFinanceRecordPageState(
//       financialRecord: financialRecord,
//     );
//   }

//   // ------------------------------------------------------------
//   // View All Expenses
//   // ------------------------------------------------------------
//   void viewAllExpenses() {
//     state = ViewAllExpensesState();
//   }

//   // ------------------------------------------------------------
//   // View All Rental entries
//   // ------------------------------------------------------------
//   void viewAllRentalEntries() {
//     state = ViewAllRentalEntriesState();
//   }
//   // ------------------------------------------------------------
//   // Update Financial Record
//   // ------------------------------------------------------------

//   void updateFinancialRecord(FinancialRecord financialRecord) {
//     state = UpdateFinanceRecordPageState(financialRecord: financialRecord);
//   }
//   // ------------------------------------------------------------
//   // Update Rent Entry Record
//   // ------------------------------------------------------------

//   void updateRentEntryRecord(SingleRentEntry financialRecord) {
//     state = UpdateRentEntryRecordPageState(financialRecord: financialRecord);
//   }

//   // ------------------------------------------------------------
//   // Expenses Per Property
//   // ------------------------------------------------------------

//   void viewExpensesPerProperty() {
//     state = ExpensesPerPropertyState();
//   }

//   // ------------------------------------------------------------
//   // Rent Per Tenant
//   // ------------------------------------------------------------

//   void viewRentPerTenant() {
//     state = RentPerTenantState();
//   }
// }
import 'package:anyamar/commons/exports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'finances_notifier.g.dart';

@riverpod
class FinancesPageNotifier extends _$FinancesPageNotifier {
  final List<FinancesPageState> _history = [];

  @override
  FinancesPageState build() {
    if (_history.isEmpty) {
      _history.add(const FinancesTablePageState());
    }

    return _history.last;
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void goTo(FinancesPageState newState) {
    _history.add(newState);
    state = newState;
  }

  void goBack() {
    if (_history.length <= 1) {
      return;
    }

    _history.removeLast();
    state = _history.last;
  }

  bool get canGoBack => _history.length > 1;

  void goToFinancesTable() {
    _history
      ..clear()
      ..add(const FinancesTablePageState());

    state = _history.last;
  }

  // ============================================================
  // FINANCES TABLE
  // ============================================================

  void financesTable() {
    goTo(const FinancesTablePageState());
  }

  // ============================================================
  // ADD EXPENSE
  // ============================================================

  void addExpenseRecord() {
    goTo(const AddExpenseFinanceRecordPageState());
  }

  // ============================================================
  // ADD RENTAL INCOME
  // ============================================================

  void addIncomeRecord() {
    goTo(const AddIncomeFinanceRecordPageState());
  }

  // ============================================================
  // VIEW EXPENSE FINANCIAL RECORD
  // ============================================================

  void viewFinancialRecord(FinancialRecord financialRecord) {
    goTo(ViewExpenseFinanceRecordPageState(financialRecord: financialRecord));
  }

  // ============================================================
  // VIEW RENT ENTRY RECORD
  // ============================================================

  void viewRentEntryRecord(SingleRentEntry financialRecord) {
    goTo(
      ViewRentEntryFinanceRecordPageState(financialRecord: financialRecord),
    );
  }

  // ============================================================
  // VIEW ALL EXPENSES
  // ============================================================

  void viewAllExpenses() {
    goTo(const ViewAllExpensesState());
  }

  // ============================================================
  // VIEW ALL RENTAL ENTRIES
  // ============================================================

  void viewAllRentalEntries() {
    goTo(const ViewAllRentalEntriesState());
  }

  // ============================================================
  // UPDATE FINANCIAL RECORD
  // ============================================================

  void updateFinancialRecord(FinancialRecord financialRecord) {
    goTo(UpdateFinanceRecordPageState(financialRecord: financialRecord));
  }

  // ============================================================
  // UPDATE RENT ENTRY
  // ============================================================

  void updateRentEntryRecord(SingleRentEntry financialRecord) {
    goTo(UpdateRentEntryRecordPageState(financialRecord: financialRecord));
  }

  // ============================================================
  // EXPENSES PER PROPERTY
  // ============================================================

  void viewExpensesPerProperty() {
    goTo(const ExpensesPerPropertyState());
  }

  // ============================================================
  // RENT PER TENANT
  // ============================================================

  void viewRentPerTenant() {
    goTo(const RentPerTenantState());
  }

  //===========================================================
  // GO TO EXPENSES / PROPERTY
  //===========================================================

  void viewPropertyExpenses(Property property) {
    goTo(PropertyExpensesState(property: property));
  }
}
