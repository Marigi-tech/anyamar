import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/data_sets/properties.dart';
import 'package:test_app/views/reusable_widgets/buttons/button_widget.dart';
import 'package:test_app/views/tables/properties_table.dart';

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
                    child: PropertiesTable(myProperties: properties),
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
