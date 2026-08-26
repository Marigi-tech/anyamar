import 'package:anyamar/constants/commons.dart';

import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard/finances/records/general_financial_record.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/financial_records_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevenueCardWidget extends ConsumerStatefulWidget {
  const RevenueCardWidget({super.key});

  @override
  ConsumerState<RevenueCardWidget> createState() => _RevenueCardWidgetState();
}

class _RevenueCardWidgetState extends ConsumerState<RevenueCardWidget> {
  @override
  Widget build(BuildContext context) {
    //User specific financial records
    List<FinancialRecord> financialRecords = ref.watch(
      userInformationProvider.select((state) => state.finances),
    );
    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return Container(
          width: Responsiveness.isDesktop(context)
              ? getSizeFromContext(context).width * .50
              : double.infinity,
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                //Enter card title here
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Financial Records',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          //Add Button
                          ColorButtonWidget(
                            onPressedCallBack: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => AddGeneralFinancialRecord(),
                              ),
                            ),
                            buttonTitle: 'Add Record',
                            fontSize: 11,
                            buttonColor: AppColorsConstant.blueColor,
                          ),
                          SizedBox(width: 15),
                          //View button
                          ColorButtonWidget(
                            onPressedCallBack: () {
                              selectedWebPageNotifier.value = 2;
                            },
                            buttonTitle: 'View all',
                            fontSize: 11,
                            buttonColor: AppColorsConstant.greenColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //Divider
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(thickness: 0.18, height: 10.0),
                ),
                SizedBox(height: 10.0),

                // Scrollable Table Section
                // Financial Records
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: FinancialRecordsTable(
                      financialRecords: financialRecords,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
