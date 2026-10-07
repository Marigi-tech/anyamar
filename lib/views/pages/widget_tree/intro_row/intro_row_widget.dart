import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/sidebar_notifier_provider.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/welcome_text.dart';

class IntroRowWidget extends ConsumerWidget {
  const IntroRowWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDarkMode = ref.watch(themeIsDarkProvider);
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: themeIsDarkMode != true
            ? AppColors.whiteColor
            : AppColors.darkBackground,
        border: Border(
          bottom: BorderSide(
            color: themeIsDarkMode == true
                ? AppColors.darkBorder
                : AppColors.lightBorder,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              ref.read(sideBarProvider.notifier).toggleSidebar();
            },
            icon: Icon(Icons.menu),
          ),

          const SizedBox(width: 30),

          Expanded(
            child: SizedBox(
              height: 42,
              child: TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(CupertinoIcons.search),
                ),
                // ),
              ),
            ),
          ),

          const SizedBox(width: 30),

          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
              ),

              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ThemeToggleWidget(),
          const SizedBox(width: 12),

          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xffDDE7FF),
            child: UserNameText(isInitials: true),
          ),

          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: () => showDialog(
              context: context,
              builder: (dialogContext) {
                return AddItemsWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
