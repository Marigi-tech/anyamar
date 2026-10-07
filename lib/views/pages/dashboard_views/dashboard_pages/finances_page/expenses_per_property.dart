import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/expenses_per_property_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/expense_per_property_table.dart';

class ExpensesPerProperty extends ConsumerStatefulWidget {
  const ExpensesPerProperty({super.key});

  @override
  ConsumerState<ExpensesPerProperty> createState() =>
      _ExpensesPerPropertyState();
}

class _ExpensesPerPropertyState extends ConsumerState<ExpensesPerProperty> {
  List<Tenant> propertyTenants = [];
  List<Unit> propertyUnits = [];
  List<Unit> occupiedUnits = [];
  double totalExpectedRent = 0.0;
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(appDataProvider);
    List<FinancialRecord> expenses = appData.finances
        .where((record) => record.recordNature == FinancialRecordNature.expense)
        .toList();
    List<Property> propertiesWithRecordedExpenses = appData.properties
        .where(
          (property) =>
              expenses.map((e) => e.propertyId).contains(property.propertyId),
        )
        .toList();

    return Column(
      children: [
        // --------------------------------------------
        // Data Row
        // --------------------------------------------
        ExpensesPerPropertySummaryCards(
          properties: propertiesWithRecordedExpenses,
        ),

        SizedBox(height: 30.0),
        // --------------------------------------------
        // Table
        // --------------------------------------------
        ExpensesPerPropertyTable(
          properties: propertiesWithRecordedExpenses,
          expenseRecords: expenses,
        ),
      ],
    );
  }
}
