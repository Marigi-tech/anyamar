import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/data_sets/rent_history.dart';
import 'package:test_app/data/models/single_rental_entry_model.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';
import 'package:test_app/views/widgets/tables/rent_history.dart';

class RevenueCardWidget extends StatefulWidget {
  const RevenueCardWidget({super.key});

  @override
  State<RevenueCardWidget> createState() => _RevenueCardWidgetState();
}

class _RevenueCardWidgetState extends State<RevenueCardWidget> {
  @override
  Widget build(BuildContext context) {
    //todo: user specific rent entries
    List<SingleRentEntry> allRentEntries = rentHistory
        .expand<SingleRentEntry>(
          (history) => history.rentEntries!.cast<SingleRentEntry>(),
        )
        .toList();
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
                // RentHistoryTable(rentEntries: allRentEntries),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: RentHistoryTable(rentEntries: allRentEntries),
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
