import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_record_info_column.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/widgets/financial_summary_cards.dart';

class SingleFinancialRecordPage extends ConsumerWidget {
  final FinancialRecord? financialRecord;
  final SingleRentEntry? rentEntry;
  final String introText;
  const SingleFinancialRecordPage({
    super.key,
    this.financialRecord,
    this.rentEntry,
    required this.introText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
             
                  SizedBox(height: 20.0),
                 
                  SizedBox(height: 20.0),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
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
                        FinancialRecordInformationColumn(
                          financialRecord: financialRecord,
                          rentEntry: rentEntry,
                        ),

                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  SizedBox(width: 25.0),
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
