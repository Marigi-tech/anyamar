import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/property_page_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_records/property_records.dart';

class ExpensesPerPropertyWidget extends ConsumerWidget {
  final List<FinancialRecord> expenseRecords;
  final Property property;
  final String introText;
  const ExpensesPerPropertyWidget({
    super.key,
    required this.expenseRecords,
    required this.property,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // --------------------------------------------
          // Data Row
          // --------------------------------------------
          SinglePropertyPageSummaryCards(property: property),
          SizedBox(height: 20.0),
          PropertyRecords(
            property: property,
            introText: '$introText / expense records',
          ),
        ],
      ),
    );
  }
}
