import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/rental_month_breakdown_column.dart';
import 'package:anyamar/tables/rent_entries_table.dart';

class RentalMonthWidget extends ConsumerWidget {
  final RentalMonth rentalMonth;
  final Tenant tenant;
  final Unit? unit;
  final String introText;
  const RentalMonthWidget({
    super.key,
    required this.rentalMonth,
    required this.tenant,
    this.unit,
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
                    RentalMonthBreakdownColumn(
                      rentalMonth: rentalMonth,
                      tenant: tenant,
                      unit: unit,
                    ),
                    // SizedBox(height: 15.0),
                    // RentalMonthTenantInfoColumn(tenant: tenant),
                    SizedBox(height: 30.0),
                    RentalEntriesTable(
                      rentEntries: rentEntries,
                      tenant: tenant,
                      unit: unit,
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
                        tenant: tenant,
                        unit: unit,
                        introText: introText,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RentalMonthBreakdownColumn(
                            rentalMonth: rentalMonth,
                            tenant: tenant,
                            unit: unit,
                          ),
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
