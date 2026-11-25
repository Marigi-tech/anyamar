import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/unavailable_info/unavailable_info_model.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/logo_widget/logo_widget.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/welcome_text.dart';

class SidebarWidget extends ConsumerWidget {
  final List<dynamic> pages;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SidebarWidget({
    super.key,
    required this.pages,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    final appUser = appData.appUser;
    final themeIsDark = ref.watch(themeIsDarkProvider);
    bool isMobile = Responsiveness.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: themeIsDark
            ? AppColors.darkElevatedCard
            : AppColors.sideBarColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.zero,

      // padding: const EdgeInsets.fromLTRB(15, 28, 10, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          SizedBox(height: 20),
          LogoWidget(),

          const SizedBox(height: 20.0),
          const Divider(thickness: 2.0),
          const SizedBox(height: 20.0),
          // --- DASHBOARD LINKS ---
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 180),

              child: ListView.builder(
                itemCount: dashboardItems.length,
                itemBuilder: (context, index) {
                  final item = dashboardItems[index];

                  return SideBarItemWidget(
                    icon: item.icon,
                    title: item.title,
                    index: item.index,
                    onPressedCallBack: () async {
                      await ref
                          .read(workspaceProvider.notifier)
                          .closeWorkspace();
                      await ref
                          .read(selectedPageProvider.notifier)
                          .selectPage(item.index!);
                      //close drawer if in mobile mode
                      if (isMobile) {
                        scaffoldKey.currentState?.closeDrawer();
                      }
                    },
                  );
                },
              ),
            ),
          ),

          // User
          !appData.isLoading
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20.0,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xff18365F))),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0xffDDE7FF),
                        child: UserNameText(isInitials: true),
                      ),

                      const SizedBox(width: 25),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UserNameText(),
                            SizedBox(height: 3),
                            Text(
                              appUser?.userType ?? '',
                              style: TextStyle(
                                color: Color(0xffAFC2DF),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () => showGeneralDialog(
                          context: context,
                          useRootNavigator: true,
                          barrierDismissible: false,
                          barrierLabel: 'Log Out',
                          barrierColor: Colors.transparent,
                          transitionDuration: const Duration(milliseconds: 250),

                          pageBuilder:
                              (dialogContext, animation, secondaryAnimation) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InfoUnavailableOverlay(
                                    isError: true,
                                    unavailableInfo: UnavailableInfoModel(
                                      text: 'Log Out',
                                      supplementaryText:
                                          ' Hello  ${appUser?.userName} \n Are you sure you want to log out of your account ?',
                                      closeMethod: () {
                                        Navigator.of(
                                          dialogContext,
                                          rootNavigator: true,
                                        ).pop();
                                      },
                                      ctaButtonWidget: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButtonWidget(
                                            isClear: true,
                                            buttonTitle: 'Cancel',
                                            onButtonPressedCallBack: () =>
                                                Navigator.pop(context),
                                          ),
                                          SizedBox(width: 06),
                                          ElevatedButtonWidget(
                                            buttonTitle: 'Log Out',
                                            buttonColor: AppColors.red,
                                            onButtonPressedCallBack: () async {
                                              await ref
                                                  .read(
                                                    selectedPageProvider
                                                        .notifier,
                                                  )
                                                  .selectPage(0);
                                              //dispose providers??

                                              //Log out
                                              await ref
                                                  .read(authServiceProvider)
                                                  .signOutUser();
                                              //dismiss alert
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: const SizedBox.expand(),
                                  ),
                                );
                              },

                          transitionBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                        ),

                        icon: Icon(Icons.keyboard_arrow_down),
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
