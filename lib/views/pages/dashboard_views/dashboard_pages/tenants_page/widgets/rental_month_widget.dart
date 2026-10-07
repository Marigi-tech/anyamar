import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/rental_month_breakdown_column.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/rent_entries_table.dart';

class RentalMonthWidget extends ConsumerWidget {
  final RentalMonth rentalMonth;
  final Tenant tenant;
  const RentalMonthWidget({
    super.key,
    required this.rentalMonth,
    required this.tenant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appData = ref.watch(appDataProvider);
    List<SingleRentEntry> rentEntries = rentalMonth.rentEntries.toList();

    return Column(
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
                  ),
                  SizedBox(height: 15.0),
                  RentalMonthTenantInfoColumn(tenant: tenant),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: RentalMonthBreakdownColumn(
                      rentalMonth: rentalMonth,
                      tenant: tenant,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(child: RentalMonthTenantInfoColumn(tenant: tenant)),
                ],
              ),

        SizedBox(height: 30.0),
        RentalEntriesTable(rentEntries: rentEntries, tenant: tenant),
      ],
    );
  }
}
