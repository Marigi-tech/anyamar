import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/tables/rent_entries_table.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/rental_month_breakdown_column.dart';

class PropertyRentalMonthWidget extends ConsumerWidget {
  final RentalMonth rentalMonth;
  final String introText;
  final Property property;
  const PropertyRentalMonthWidget({
    super.key,
    required this.rentalMonth,
    required this.property,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<SingleRentEntry> rentEntries = rentalMonth.rentEntries.toList();

    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RentalMonthSummaryCards(rentalMonth: rentalMonth),
          SizedBox(height: 30.0),
          Responsiveness.isMobile(context)
              ? Column(
                  children: [
                    RentalMonthBreakdownColumn(rentalMonth: rentalMonth),
                    // SizedBox(height: 15.0),
                    // RentalMonthTenantInfoColumn(tenant: tenant),
                    SizedBox(height: 30.0),
                    RentalEntriesTable(
                      rentEntries: rentEntries,
                      tenant: null,
                      property: property,
                      unit: null,
                      introText: introText,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: RentalEntriesTable(
                        rentEntries: rentEntries,
                        tenant: null,
                        unit: null,
                        introText: introText,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RentalMonthBreakdownColumn(rentalMonth: rentalMonth),
                          SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
