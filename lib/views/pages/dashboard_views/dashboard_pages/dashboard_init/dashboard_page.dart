import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/sidebar_notifier_provider.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/intro_row_widget.dart';
import 'package:anyamar/views/pages/widget_tree/pages_list/pages_list.dart';

class DashboardWidget extends ConsumerWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSidebarVisible = ref.watch(sideBarProvider);
    final themeIsDarkMode = ref.watch(themeIsDarkProvider);
    return Scaffold(
      backgroundColor: themeIsDarkMode == true
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      drawer: isSidebarVisible && Responsiveness.isMobile(context)
          ? Drawer(elevation: 6, child: SidebarWidget(pages: webPages))
          : null,

      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Desktop Sidebar with animation
          if (isSidebarVisible && !Responsiveness.isMobile(context))
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              width: 220,
              child: SidebarWidget(pages: webPages),
            ),

          // Page Area
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Intro row
                IntroRowWidget(),
                //Actual page content starts here
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: selectedWebPageNotifier,
                    builder: (_, value, __) => webPages.elementAt(value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Only mobile bottom nav
      // bottomNavigationBar: isMobile ? const NavbarWidget() : null,
    );
  }
}
