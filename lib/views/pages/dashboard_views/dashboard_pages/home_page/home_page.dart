import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/dashboard_cards_row/dashboard_cards_row_widget.dart';

import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/occupancy_widget/occupancy_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/rent_collection_card/rent_collection_card_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/rent_payments/recent_rent_payments.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appDataProvider);
    return DashboardPageStructure(
      introText: 'Dashboard',
      pageTitle:
          'Hello ${appData.appUser?.userName.trim().split(' ').first ?? ''} \u{1F44B}',
      supplementaryText: 'Here\'s what happening with your properties today',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Add New',
          buttonIcon: Icon(Icons.add),
          onButtonPressedCallBack: () {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return AddItemsWidget();
              },
            );
          },
        ),
      ],

      scrollableDashboardWidget: Column(
        children: [
          DashboardCardsRowWidget(),
          const SizedBox(height: 20.0),
          Responsiveness.isDesktop(context)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Rent payment , Occupancy , Tenants
                    Row(
                      children: [
                        Expanded(child: RentCollectionCard()),
                        SizedBox(width: 15),
                        Expanded(child: OccupancyCardWidget()),
                        SizedBox(width: 15),
                        Expanded(child: TenantInformationCardWidget()),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    //Recent Payments & Notifications
                    Row(
                      children: [
                        Expanded(flex: 2, child: RecentPaymentsCard()),
                        //TODO: REMINDERS
                        // SizedBox(width: 15),
                        // Expanded(child: UpcomingRemindersCard()),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    //Rent Collection
                    RentCollectionCard(),
                    SizedBox(height: 15.0),
                    //Occupancy
                    OccupancyCardWidget(),
                    SizedBox(height: 15),
                    //Tenant Information
                    TenantInformationCardWidget(),
                    SizedBox(height: 15),
                    //Recent Payments
                    RecentPaymentsCard(),

                    // SizedBox(height: 15),
                    // //Upcoming reminders
                    //TODO: REMINDERS
                    // UpcomingRemindersCard(),
                  ],
                ),
        ],
      ),
    );
  }
}
