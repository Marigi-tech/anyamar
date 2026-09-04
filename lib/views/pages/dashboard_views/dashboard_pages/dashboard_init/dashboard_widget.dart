import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/intro_row_widget.dart';
import 'package:anyamar/views/pages/widget_tree/pages_list/pages_list.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsiveness.isMobile(context);
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: isSidebarCollapsedNotifier,
        builder: (context, isCollapsed, child) {
          return Row(
            children: [
              /// Desktop Sidebar with animation
              if (!isMobile)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: isCollapsed ? 90 : 200,
                  child: SidebarWidget(pages: webPages),
                ),

              // Page Area
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Intro row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: IntroRowWidget(),
                    ),
                    //Actual page content starts here
                    Expanded(
                      child: isMobile
                          ? ValueListenableBuilder<int>(
                              valueListenable: selectedPageNotifier,
                              builder: (_, value, __) =>
                                  webPages.elementAt(value),
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
