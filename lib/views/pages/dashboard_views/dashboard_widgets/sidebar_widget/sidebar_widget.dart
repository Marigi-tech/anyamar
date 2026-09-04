import 'package:anyamar/commons/exports.dart';

class SidebarWidget extends ConsumerWidget {
  final List<dynamic> pages;

  const SidebarWidget({super.key, required this.pages});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSidebarCollapsedNotifier,
      builder: (context, isCollapsed, child) {
        // --- CONTAINER SETUP ---
        return Card(
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          margin: EdgeInsets.zero,

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
                      isCollapsed
                          ? Icons.expand_more_rounded
                          : CupertinoIcons.minus_circled,
                    ),
                  ),
                ],
              ),

              Text(
                isCollapsed ? 'A' : 'Anyamar',
                style: TextStyle(
                  color: AppColorsConstant.darkBlueColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 6.0,
                ),
              ),

              const SizedBox(height: 20.0),
              const Divider(thickness: 2.0),
              const SizedBox(height: 20.0),
              // --- DASHBOARD LINKS ---
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 180),

                    child: ListView.builder(
                      itemCount: dashboardItems.length,
                      itemBuilder: (context, index) {
                        final item = dashboardItems[index];

                        return ValueListenableBuilder(
                          valueListenable: selectedWebPageNotifier,
                          builder: (context, pageIndex, child) {
                            return SideBarItemWidget(
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
                ),
              ),

              // log out button
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 180),
                child: SideBarItemWidget(
                  index: 7,
                  title: 'Log Out',
                  isLogOutButton: true,
                  icon: CupertinoIcons.power,

                  onPressedCallBack: () async {
                    selectedPageNotifier.value = 0;
                    //todo: Dispose all providers

                    //Log out
                    await ref.read(authServiceProvider).signOutUser();
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
