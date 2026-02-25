import 'package:test_app/data/constants/commons.dart';

import 'package:test_app/views/widgets/buttons/button_widget.dart';

class TenantInformationCardWidget extends StatelessWidget {
  const TenantInformationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy tenants info
    final List<Map<String, String>> tenants = [
      {"name": "John Doe", "property": "Sunrise Apartments"},
      {"name": "Mary Kim", "property": "Emerald Estate"},
      {"name": "Alex Maina", "property": "Hillview Homes"},
      {"name": "Grace Wairimu", "property": "Palm Villas"},
      {"name": "Samuel Kip", "property": "BlueSky Towers"},
    ];
    //TODO:list of alternating avatar colors
    final List<Color> avatarBackgroundColors = [
      AppColorsConstant.darkBlueColor,
      AppColorsConstant.darkGreenColor,
      AppColorsConstant.darkYellowColor,
      AppColorsConstant.redColor,
    ];
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
                        'Tenants',
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
                              selectedWebPageNotifier.value = 3;
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

                Expanded(
                  child: ListView.separated(
                    itemCount: tenants.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 12, thickness: 0.15),
                    itemBuilder: (context, index) {
                      final tenant = tenants[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              avatarBackgroundColors[index %
                                  avatarBackgroundColors.length],
                          child: Text(
                            tenant["name"]![0],
                            style: const TextStyle(
                              fontWeight: FontWeight.w200,
                              color: AppColorsConstant.whiteColor,
                            ),
                          ),
                        ),
                        title: Text(
                          tenant["name"]!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          tenant["property"]!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColorsConstant.blueGreyColor,
                          ),
                        ),
                        onTap: () {},
                      );
                    },
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
