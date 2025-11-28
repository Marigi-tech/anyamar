import 'package:test_app/data/constants/commons.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isSidebarCollapsed = false; // controls collapse/expand

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsiveness.isMobile(context);

    final List<Widget> pages = [
      PropertiesPage(),
      FinancesPage(),
      HomePage(),
      ChatsPage(),
      ProfilePage(),
    ];

    final List<Widget> webPages = [
      HomePage(),
      PropertiesPage(),
      FinancesPage(),
      TenantsPage(),
      ChatsPage(),
      SettingsPage(),
      ProfilePage(),
    ];

    return Scaffold(
      key: scaffoldKey,

      // Mobile drawer only
      body: ValueListenableBuilder(
        valueListenable: isSidebarCollapsedNotifier,
        builder: (context, value, child) {
          return Row(
            children: [
              /// Desktop Sidebar with animation
              if (!isMobile) //For desktop / tablets and above (not phones)
                AnimatedContainer(
                  duration: const Duration(microseconds: 1),
                  curve: Curves.easeInOut,
                  width: isSidebarCollapsedNotifier.value ? 90 : 250,
                  child: SidebarWidget(pages: pages),
                ),

              // Page Area
              Expanded(
                child: isMobile
                    ? ValueListenableBuilder<int>(
                        valueListenable: selectedPageNotifier,
                        builder: (_, value, __) => pages.elementAt(value),
                      )
                    : ValueListenableBuilder<int>(
                        valueListenable: selectedWebPageNotifier,
                        builder: (_, value, __) => webPages.elementAt(value),
                      ),
              ),
            ],
          );
        },
      ),

      // Only mobile bottom nav
      bottomNavigationBar: isMobile ? const NavbarWidget() : null,
    );
  }
}
