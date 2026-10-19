import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/sidebar_notifier_provider.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/dashboard_init/data_loading_overlay.dart';

import 'package:anyamar/views/pages/widget_tree/intro_row/intro_row_widget.dart';
import 'package:anyamar/views/pages/widget_tree/pages_list/pages_list.dart';

class DashboardWidget extends ConsumerStatefulWidget {
  const DashboardWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardWidgetState();
}

class _DashboardWidgetState extends ConsumerState<DashboardWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isSidebarVisible = ref.watch(sideBarProvider);
    final themeIsDarkMode = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);

    // final baseColor = themeIsDarkMode
    //     ? AppColors.darkElevatedCard
    //     : AppColors.lightCard;

    // final highlightColor = themeIsDarkMode
    //     ? const Color(0xFF3A4658)
    //     : const Color(0xFFEAF1FA);

    return Scaffold(
      key: _scaffoldKey,
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
                IntroRowWidget(scaffoldKey: _scaffoldKey),

                //Actual page content starts here
                // Expanded(child: MainWorkspace()),
                Expanded(
                  child: DataLoadingOverlay(
                    isLoading: appData.isLoading,
                    isDarkMode: themeIsDarkMode,
                    child: Skeletonizer(
                      enabled: appData.isLoading,
                      enableSwitchAnimation: true,
                      effect: ShimmerEffect(
                        baseColor: themeIsDarkMode
                            ? AppColors.darkElevatedCard
                            : AppColors.lightCard,
                        highlightColor: themeIsDarkMode
                            ? const Color(0xFF3A4658)
                            : const Color(0xFFEAF1FA),
                        duration: const Duration(milliseconds: 1500),
                      ),
                      child: MainWorkspace(),
                    ),
                  ),
                ),

                // Expanded(
                //   child: Skeletonizer(
                //     effect: ShimmerEffect(
                //       baseColor: baseColor,
                //       highlightColor: highlightColor,
                //       duration: const Duration(milliseconds: 100),
                //     ),
                //     enabled: appData.isLoading,
                //     enableSwitchAnimation: true,
                //     child: MainWorkspace(),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
