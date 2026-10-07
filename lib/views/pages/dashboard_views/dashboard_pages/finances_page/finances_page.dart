import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/finances_page/finances_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_expenses_page_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/add_income_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/expense_per_property_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/finances_table_page_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/update_expense_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_all_expenses_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_all_rent_entries_state.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_expense_record_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/view_rent_entry_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/page_states/view_property_state_page.dart';

// ============================================================
// PAGE STATES
// ============================================================
sealed class FinancesPageState {
  const FinancesPageState();
}

class FinancesTablePageState extends FinancesPageState {
  const FinancesTablePageState();
}

class AddExpenseFinanceRecordPageState extends FinancesPageState {
  const AddExpenseFinanceRecordPageState();
}

class AddIncomeFinanceRecordPageState extends FinancesPageState {
  const AddIncomeFinanceRecordPageState();
}

class ViewAllExpensesState extends FinancesPageState {
  const ViewAllExpensesState();
}

class ViewAllRentalEntriesState extends FinancesPageState {
  const ViewAllRentalEntriesState();
}

class ViewExpenseFinanceRecordPageState extends FinancesPageState {
  final FinancialRecord financialRecord;
  const ViewExpenseFinanceRecordPageState({required this.financialRecord});
}

class ViewRentEntryFinanceRecordPageState extends FinancesPageState {
  final SingleRentEntry financialRecord;
  const ViewRentEntryFinanceRecordPageState({required this.financialRecord});
}

class UpdateFinanceRecordPageState extends FinancesPageState {
  final FinancialRecord financialRecord;

  const UpdateFinanceRecordPageState({required this.financialRecord});
}

class UpdateRentEntryRecordPageState extends FinancesPageState {
  final SingleRentEntry financialRecord;

  const UpdateRentEntryRecordPageState({required this.financialRecord});
}

class RentPerTenantState extends FinancesPageState {
  const RentPerTenantState();
}

class ExpensesPerPropertyState extends FinancesPageState {
  const ExpensesPerPropertyState();
}

class PropertyExpensesState extends FinancesPageState {
  final Property property;
  const PropertyExpensesState({required this.property});
}

// ============================================================
// BASE FINANCES PAGE
// ============================================================
class FinancesPage extends ConsumerWidget {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financesPageState = ref.watch(financesPageProvider);

    return switch (financesPageState) {
      FinancesTablePageState() => FinancesTablePage(),
      ViewAllExpensesState() => ViewAllExpensesStatePage(),
      ViewAllRentalEntriesState() => ViewAllRentEntriesPageState(),
      AddExpenseFinanceRecordPageState() => AddExpensesStatePage(),
      AddIncomeFinanceRecordPageState() => AddIncomeStatePage(),
      ViewExpenseFinanceRecordPageState(:final financialRecord) =>
        ViewExpenseRecordStatePage(financialRecord: financialRecord),
      ViewRentEntryFinanceRecordPageState(:final financialRecord) =>
        ViewRentEntryStatePage(financialRecord: financialRecord),

      UpdateFinanceRecordPageState(:final financialRecord) =>
        UpdateExpenseRecord(financialRecord: financialRecord),

      UpdateRentEntryRecordPageState(:final financialRecord) => UpdateRentEntry(
        rentEntry: financialRecord,
      ),
      ExpensesPerPropertyState() => ExpensesPerPropertyStatePage(),
      RentPerTenantState() => RentPerTenantStatePage(),
      PropertyExpensesState(:final property) => ViewPropertyStatePage(
        property: property,
      ),
    };
  }
}
