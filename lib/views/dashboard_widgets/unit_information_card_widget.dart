import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/data_sets/units.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/reusable_widgets/buttons/button_widget.dart';
import 'package:test_app/views/tables/units_table.dart';

class UnitInformationCardWidget extends StatelessWidget {
  final Property property;
  const UnitInformationCardWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    List<Unit> propertyUnits = units
        .where((element) => element.propertyId == property.propertyId)
        .toList();
    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return Container(
          width: Responsiveness.isDesktop(context)
              ? getSizeFromContext(context).width * .60
              : double.infinity,
          height: 400,

          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                        'Units',
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
                              //todo:Add unit logic
                              // selectedWebPageNotifier.value = 1;
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
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: UnitsTable(units: propertyUnits),
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
