import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/views/pages/initial_pages/landing_page/landing_page.dart';

class SidebarWidget extends StatelessWidget {
  final List<dynamic> pages;

  const SidebarWidget({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSidebarCollapsedNotifier,
      builder: (context, isCollapsed, child) {
        // --- CONTAINER SETUP ---
        return Container(
          // Set width based on the notifier state
          // width: isCollapsed ? getSizeFromContext(context).width * .058 : null,
          // Full width (or constrained by parent) for expanded state
          // Apply horizontal padding ONLY when expanded, not when collapsed.
          padding: isCollapsed
              ? null // No padding when collapsed, helps prevent overflow
              : const EdgeInsets.symmetric(horizontal: 30.0),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            color: themeIsDarkNotifier.value
                ? AppColorsConstant.darkNavColor
                : AppColorsConstant.lightNavColor,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // --- TOGGLE BUTTON ROW ---
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      isSidebarCollapsedNotifier.value = !isCollapsed;
                    },
                    icon: Icon(
                      isCollapsed ? Icons.expand_more_rounded : Icons.minimize,
                    ),
                  ),
                ],
              ),

              Visibility(
                visible: true,
                maintainSize: true, // Keep the space it would occupy
                maintainAnimation: true,
                maintainState: true,
                child: Text(
                  isCollapsed ? 'A' : 'Anyamar',
                  style: TextStyle(
                    color: AppColorsConstant.darkBlueColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 6.0,
                  ),
                ),
              ),

              const SizedBox(height: 20.0),
              const Divider(thickness: 2.0),
              const SizedBox(height: 20.0),
              // --- DASHBOARD LINKS ---
              Expanded(
                child: ListView.builder(
                  itemCount: dashboardItems.length,
                  itemBuilder: (context, index) {
                    final item = dashboardItems[index];

                    return ValueListenableBuilder(
                      valueListenable: selectedWebPageNotifier,
                      builder: (context, pageIndex, child) {
                        return item.index == 7
                            //---Log out button--//
                            ? Padding(
                                padding: EdgeInsets.only(top: 30.0),
                                child: SideBarItemWidget(
                                  icon: item.icon,
                                  title: item.title,
                                  isLogOutButton: true,
                                  index: item.index,
                                  onPressedCallBack: () {
                                    selectedPageNotifier.value = 0;

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LandingPage(),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SideBarItemWidget(
                                icon: item.icon,
                                title: item.title,
                                index: item.index,
                                onPressedCallBack: () async {
                                  selectedWebPageNotifier.value = item.index!;
                                  selectedSideItemNotifier.value = item.index!;
                                },
                              );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
