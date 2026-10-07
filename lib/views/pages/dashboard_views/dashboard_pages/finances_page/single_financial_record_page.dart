import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_record_info_column.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/quick_expenses_actions.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/quick_rent_entry_actions.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/related_info_column.dart';

class SingleFinancialRecordPage extends ConsumerWidget {
  final FinancialRecord? financialRecord;
  final SingleRentEntry? rentEntry;
  const SingleFinancialRecordPage({
    super.key,
    this.financialRecord,
    this.rentEntry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appDataProvider);

    final personName = financialRecord != null
        ? financialRecord?.paymentBy.personName
        : rentEntry?.tenantName;
    Unit? unit = appData.units
        .where((u) => u.unitId == rentEntry?.unitId)
        .singleOrNull;
    // String? unitName = rentEntry != null
    //     ? appData.units
    //           .where((u) => u.unitId == rentEntry?.unitId)
    //           .singleOrNull
    //           ?.unitName
    //     : null;
    String? propertyName = financialRecord != null
        ? appData.properties
              .where((p) => p.propertyId == financialRecord?.propertyId)
              .singleOrNull
              ?.propertyName
        : appData.properties
              .where((p) => p.propertyId == unit?.propertyId)
              .singleOrNull
              ?.propertyName;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Responsiveness.isMobile(context)
            ? Column(
                children: [
                  // --------------------------------------------
                  // Data Row
                  // --------------------------------------------
                  rentEntry != null
                      ? SingleRentEntrySummaryCards(financialRecord: rentEntry!)
                      : SingleFinancialRecordSummaryCards(
                          financialRecord: financialRecord!,
                        ),
                  SizedBox(height: 30.0),
                  FinancialRecordInformationColumn(
                    financialRecord: financialRecord,
                    rentEntry: rentEntry,
                  ),
                  // UnitInformationColumn(unit: widget.unit),
                  SizedBox(height: 20.0),
                  RelatedInfoColumn(
                    personName: personName,
                    unitName: unit?.unitName,
                    propertyName: propertyName,
                    isRent: rentEntry != null ? true : false,
                  ),
                  SizedBox(height: 20.0),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // --------------------------------------------
                        // Data Row
                        // --------------------------------------------
                        rentEntry != null
                            ? SingleRentEntrySummaryCards(
                                financialRecord: rentEntry!,
                              )
                            : SingleFinancialRecordSummaryCards(
                                financialRecord: financialRecord!,
                              ),
                        SizedBox(height: 20.0),
                        // SizedBox(height: 30.0),
                        Row(
                          children: [
                            Expanded(
                              child: FinancialRecordInformationColumn(
                                financialRecord: financialRecord,
                                rentEntry: rentEntry,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: RelatedInfoColumn(
                                personName: personName,
                                unitName: unit?.unitName,
                                propertyName: propertyName,
                                isRent: rentEntry != null ? true : false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  SizedBox(width: 25.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Tenant Info
                        if (financialRecord != null)
                          QuickExpensesActions(expenseRecord: financialRecord),
                        if (rentEntry != null)
                          QuickRentEntryActions(rentEntry: rentEntry),

                        SizedBox(height: 20.0),

                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class SingleRentEntryRecordPage extends StatelessWidget {
  const SingleRentEntryRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SingleExpenseRecordPage extends StatelessWidget {
  const SingleExpenseRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
