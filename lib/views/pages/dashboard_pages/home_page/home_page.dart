import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/views/pages/dashboard_pages/dashboard_page_shell.dart';
import 'package:anyamar/views/pages/dashboard_pages/home_page/intro_card_list.dart';
import 'package:anyamar/views/dashboard_widgets/property_information_card_widget.dart';
import 'package:anyamar/views/dashboard_widgets/revenue_card_widget.dart';
import 'package:anyamar/views/dashboard_widgets/tenant_information_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            children: introCardsList.map((card) {
              return card;
            }).toList(),
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
                children: const [
                  // Expanded(child: ChatsCardWidget()),
                  // SizedBox(width: 10),
                  // Using TenantInformationCardWidget twice is likely a copy/paste error,
                  // this should probably be a Finances/Revenue card. Keeping it for minimal change.
                  Expanded(flex: 2, child: RevenueCardWidget()),
                ],
              )
            : Column(
                children: [
                  // const ChatsCardWidget(isInChatPage: false),
                  const RevenueCardWidget(),
                ],
              ),
      ],
    );
  }
}
