import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';
import 'package:test_app/views/widgets/tables/properties_table.dart';

class PropertyInformationCardWidget extends StatefulWidget {
  const PropertyInformationCardWidget({super.key});

  @override
  State<PropertyInformationCardWidget> createState() =>
      _PropertyInformationCardWidgetState();
}

class _PropertyInformationCardWidgetState
    extends State<PropertyInformationCardWidget> {
  @override
  Widget build(BuildContext context) {
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
                        'Properties',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          //View button
                          ColorButtonWidget(
                            onPressedCallBack: () {
                              selectedWebPageNotifier.value = 1;
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
                //Insert table here
                // Scrollable Table Section
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      border: TableBorder.symmetric(
                        outside: BorderSide.none,
                        inside: BorderSide(
                          color: AppColorsConstant.blueGreyColor,
                          width: 0.09,
                        ),
                      ),
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(2),
                        4: FlexColumnWidth(1),
                        5: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        // Header Row
                        buildHeaderRow(),

                        // Dummy Rows
                        buildDataRow(
                          1,
                          "Sunrise Apartments",
                          "Nairobi",
                          "J. Mwangi",
                          "18",
                        ),
                        buildDataRow(
                          2,
                          "Lavington Heights",
                          "Nairobi",
                          "A. Maragwa",
                          "32",
                        ),
                        buildDataRow(
                          3,
                          "Eldo Towers",
                          "Eldoret",
                          "S. Kirui",
                          "26",
                        ),
                        buildDataRow(
                          4,
                          "Coast View Homes",
                          "Mombasa",
                          "M. Said",
                          "40",
                        ),
                        buildDataRow(
                          5,
                          "Coast View Homes",
                          "Mombasa",
                          "M. Said",
                          "40",
                        ),
                        buildDataRow(
                          6,
                          "Coast View Homes",
                          "Mombasa",
                          "M. Said",
                          "40",
                        ),
                        buildDataRow(
                          7,
                          "Coast View Homes",
                          "Mombasa",
                          "M. Said",
                          "40",
                        ),
                      ],
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
