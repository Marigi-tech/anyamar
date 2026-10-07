import 'package:anyamar/commons/exports.dart';

class DashboardCardsRowWidget extends ConsumerWidget {
  const DashboardCardsRowWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appDataProvider);
    return Container(
      height: 150,
      padding: EdgeInsets.only(left: 10.0),
      width: double.infinity,
      child: GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        crossAxisSpacing: 14,
        childAspectRatio: 1.55,

        children: [
          IntroCardWidget(
            cardIcon: Icons.apartment,
            cardTitle: 'Properties',
            description: '${appData.propertyCount}',
            extraInfo: 'All properties',
            iconCardColor: const Color(0xffEDF3FF),
            iconColor: Colors.blue,
            onPressedCallBack: () {
              selectedWebPageNotifier.value = 1;
              selectedSideItemNotifier.value = 1;
            },
          ),

          IntroCardWidget(
            cardIcon: Icons.people,
            cardTitle: 'Tenants',
            extraInfo: 'Active tenants',
            iconCardColor: const Color.fromARGB(255, 252, 243, 211),
            iconColor: Colors.amberAccent,
            description: '${appData.activeTenantAcount}',
            onPressedCallBack: () {
              selectedWebPageNotifier.value = 3;
              selectedSideItemNotifier.value = 3;
            },
          ),
          IntroCardWidget(
            cardIcon: Icons.house,
            cardTitle: 'Units',
            extraInfo: 'All units',
            iconCardColor: const Color.fromARGB(255, 239, 229, 241),
            iconColor: Colors.purpleAccent,
            description: '${appData.unitCount}',
            onPressedCallBack: () {
              selectedWebPageNotifier.value = 2;
              selectedSideItemNotifier.value = 2;
            },
          ),
          IntroCardWidget(
            cardIcon: CupertinoIcons.money_dollar,
            cardTitle: 'Payments',
            description: '${appData.financeCount}',
            extraInfo: 'Payment records',
            iconCardColor: const Color.fromARGB(255, 241, 228, 228),
            iconColor: Colors.redAccent,
            onPressedCallBack: () {
              selectedWebPageNotifier.value = 4;
              selectedSideItemNotifier.value = 4;
            },
          ),
          IntroCardWidget(
            cardIcon: CupertinoIcons.money_dollar,
            cardTitle: 'Rent',
            description: '${appData.rentRecordsCount}',
            extraInfo: 'rental records',
            iconCardColor: const Color.fromARGB(255, 215, 247, 215),
            iconColor: const Color.fromARGB(255, 9, 204, 16),
            onPressedCallBack: () {
              selectedWebPageNotifier.value = 5;
              selectedSideItemNotifier.value = 5;
            },
          ),
        ],
      ),
    );
  }
}
