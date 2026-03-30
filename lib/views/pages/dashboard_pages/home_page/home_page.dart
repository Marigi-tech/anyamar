import 'package:test_app/constants/commons.dart';
import 'package:test_app/views/pages/dashboard_pages/home_page/intro_card_list.dart';
import 'package:test_app/views/dashboard_widgets/chats_card_widget.dart';
import 'package:test_app/views/dashboard_widgets/property_information_card_widget.dart';
import 'package:test_app/views/dashboard_widgets/intro_text_widget.dart';
import 'package:test_app/views/dashboard_widgets/revenue_card_widget.dart';
import 'package:test_app/views/dashboard_widgets/tenant_information_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ), // Consistent horizontal spacing for the entire page
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 1. Intro Text Widget (Simple Header)
          const SizedBox(height: 10.0),
          const IntroTextWidget(dashboardItem: 'Dashboard'),
          const SizedBox(height: 20.0),

          // 2. Horizontal Info Cards (Height must be fixed to work with horizontal scrolling)
          SizedBox(
            height: 150,
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

          const SizedBox(height: 30.0), // Increased spacing for visual break
          // 3. Property and Tenant Cards (Responsive Block)
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

          const SizedBox(height: 30.0),

          //Chats and Revenue
          Responsiveness.isDesktop(context)
              ? Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align content to the top
                  children: const [
                    Expanded(child: ChatsCardWidget()),
                    SizedBox(width: 10),
                    // Using TenantInformationCardWidget twice is likely a copy/paste error,
                    // this should probably be a Finances/Revenue card. Keeping it for minimal change.
                    Expanded(flex: 2, child: RevenueCardWidget()),
                  ],
                )
              : Column(
                  children: [
                    const ChatsCardWidget(isInChatPage: false),
                    const RevenueCardWidget(),
                  ],
                ), // On mobile, maybe only show the chat or stack them

          const SizedBox(height: 30.0), // Padding at the bottom
        ],
      ),
    );
  }
}
