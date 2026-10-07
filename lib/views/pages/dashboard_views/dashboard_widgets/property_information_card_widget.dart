import 'package:anyamar/commons/exports.dart';


class PropertyInformationCardWidget extends ConsumerStatefulWidget {
  const PropertyInformationCardWidget({super.key});

  @override
  ConsumerState<PropertyInformationCardWidget> createState() =>
      _PropertyInformationCardWidgetState();
}

class _PropertyInformationCardWidgetState
    extends ConsumerState<PropertyInformationCardWidget> {
  List<Property> myProperties = [];
  List<Unit> myUnits = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    myUnits = ref.watch(userInformationProvider.select((state) => state.units));

    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return Container(
          width: Responsiveness.isDesktop(context)
              ? getSizeFromContext(context).width * .50
              : double.infinity,
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                          //Update Button
                          ColorButtonWidget(
                            onPressedCallBack: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => AddProperty()),
                            ),
                            buttonTitle: 'Add Property',
                            fontSize: 11,
                            buttonColor: AppColorsConstant.orangeColor,
                          ),
                          SizedBox(width: 15),
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
                    child: PropertiesPage()
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
