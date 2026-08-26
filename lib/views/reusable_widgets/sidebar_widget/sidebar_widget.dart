import 'package:anyamar/data/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/landing_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                    constraints: BoxConstraints(
                      maxWidth: 180,
                    ), //?prevents renderflex issues arising from collapsing the sidebar

                    child: ListView.builder(
                      itemCount: dashboardItems.length,
                      itemBuilder: (context, index) {
                        final item = dashboardItems[index];

                        return ValueListenableBuilder(
                          valueListenable: selectedWebPageNotifier,
                          builder: (context, pageIndex, child) {
                            return item.index == 6
                                //---Log out button--//
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 30.0),
                                        child: SideBarItemWidget(
                                          icon: item.icon,
                                          title: item.title,
                                          isLogOutButton: true,
                                          index: item.index,
                                          onPressedCallBack: () async {
                                            selectedPageNotifier.value = 0;
                                            //Log out
                                            await ref
                                                .read(authServiceProvider)
                                                .signOutUser()
                                            //todo: manage widget by authstate(no need for push back to Landing)

                                            .whenComplete(
                                              () =>
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          LandingPage(),
                                                    ),
                                                  ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : SideBarItemWidget(
                                    icon: item.icon,
                                    title: item.title,
                                    index: item.index,
                                    onPressedCallBack: () async {
                                      selectedWebPageNotifier.value =
                                          item.index!;
                                      selectedSideItemNotifier.value =
                                          item.index!;
                                    },
                                  );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
