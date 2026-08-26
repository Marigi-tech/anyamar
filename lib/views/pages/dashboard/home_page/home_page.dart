import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/financial_records/financial_record_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_widgets/intro_card_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_page_shell.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_widgets/property_information_card_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_widgets/revenue_card_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_widgets/tenant_information_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/data/models/properties/property_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Property> myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    List<Tenant> myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );
    List<FinancialRecord> myRecords = ref.watch(
      userInformationProvider.select((state) => state.finances),
    );
    return DashboardPageShell(
      introText: 'Dashboard',

      dashboardWidgets: [
        Container(
          height: 150,
          padding: EdgeInsets.only(left: 10.0),
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              IntroCardWidget(
                cardIcon: CupertinoIcons.building_2_fill,
                cardTitle: 'Properties',
                description: '${myProperties.length}',
                onPressedCallBack: () {
                  selectedWebPageNotifier.value = 1;
                  selectedSideItemNotifier.value = 1;
                },
              ),

              IntroCardWidget(
                cardIcon: CupertinoIcons.person_2,
                cardTitle: 'Tenants',
                description: '${myTenants.length}',
                onPressedCallBack: () {
                  selectedWebPageNotifier.value = 3;
                  selectedSideItemNotifier.value = 3;
                },
              ),
              IntroCardWidget(
                cardIcon: CupertinoIcons.money_dollar,
                cardTitle: 'Financial Records',
                description: '${myRecords.length}',
                onPressedCallBack: () {
                  selectedWebPageNotifier.value = 2;
                  selectedSideItemNotifier.value = 2;
                },
              ),
              IntroCardWidget(
                cardIcon: CupertinoIcons.person,
                cardTitle: 'My Account',
                description: '',
                extraInfo: '',
                onPressedCallBack: () {
                  selectedWebPageNotifier.value = 5;
                  selectedSideItemNotifier.value = 5;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0), // Increased spacing for visual break
        //       // 3. Property and Tenant Cards (Responsive Block)
        Responsiveness.isDesktop(context)
            ? Row(
                // Use Row directly as the container, it will take the width of the parent (double.infinity)
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to the top
                children: const [
                  Expanded(flex: 2, child: PropertyInformationCardWidget()),
                  SizedBox(width: 10), // Add spacing between cards on desktop
                  Expanded(child: TenantInformationCardWidget()),
                ],
              )
            : Column(
                // Mobile/Tablet Stacked Layout
                children: const [
                  PropertyInformationCardWidget(),
                  SizedBox(height: 10), // Add spacing between stacked cards
                  TenantInformationCardWidget(),
                ],
              ),

        const SizedBox(height: 20.0),
        Responsiveness.isDesktop(context)
            ? Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to the top
                children: const [Expanded(flex: 2, child: RevenueCardWidget())],
              )
            : Column(children: [const RevenueCardWidget()]),
      ],
    );
  }
}
