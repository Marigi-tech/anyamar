import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/logo_widget/logo_widget.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/welcome_text.dart';

class SidebarWidget extends ConsumerWidget {
  final List<dynamic> pages;

  const SidebarWidget({super.key, required this.pages});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(
      userInformationProvider.select((state) => state.appUser),
    );
    final themeIsDark = ref.watch(themeIsDarkProvider);

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

          // User
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xff18365F))),
            ),
            child: Row(
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
                  onPressed: () => showDialog<bool>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertModal(
                        dialogTitle: 'Log Out',
                        isDeleteModal: false,
                        dialogInformation:
                            ' Hello  ${appUser?.userName} \n Are you sure you want to log out of your account ?',
                        buttonTitle: 'Log out',
                        onButtonPressedCallBack: () async {
                          selectedPageNotifier.value = 0;
                          //       //todo: Dispose all providers

                          //Log out
                          await ref.read(authServiceProvider).signOutUser();
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
