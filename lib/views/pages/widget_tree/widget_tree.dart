import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/views/pages/widget_tree/intro_row/intro_row_widget.dart';
import 'package:test_app/views/pages/widget_tree/pages_list/pages_list.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsiveness.isMobile(context);

    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: isSidebarCollapsedNotifier,
        builder: (context, isCollapsed, child) {
          return Row(
            children: [
              /// Desktop Sidebar with animation
              if (!isMobile)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: isCollapsed ? 90 : 200,
                  child: SidebarWidget(pages: pages),
                ),

              // Page Area
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //---------------------INTRO ROW------------------------//
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: IntroRowWidget(),
                    ),
                    //-------------- ACTUAL PAGE CONTENTS ----------------//
                    Expanded(
                      child: isMobile
                          ? ValueListenableBuilder<int>(
                              valueListenable: selectedPageNotifier,
                              builder: (_, value, __) => pages.elementAt(value),
                            )
                          : ValueListenableBuilder<int>(
                              valueListenable: selectedWebPageNotifier,
                              builder: (_, value, __) =>
                                  webPages.elementAt(value),
                            ),
                    ),
                  ],
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
