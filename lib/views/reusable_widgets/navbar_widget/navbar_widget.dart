import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/constants/constants.dart';
import 'package:test_app/data/notifiers.dart';
import 'package:test_app/data/providers/theme_provider.dart';
import 'package:test_app/views/reusable_widgets/navbar_widget/navbar_item.dart';

class NavbarWidget extends ConsumerStatefulWidget {
  const NavbarWidget({super.key});

  @override
  ConsumerState<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends ConsumerState<NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeIsDarkProvider);
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 20,
            top: 10,
            bottom: 20,
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,

            children: [
              ///------  Navigation bar ---------------------//
              PhysicalModel(
                elevation: 20,
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Material(
                    color: themeMode
                        ? AppColorsConstant.darkNavColor.withValues(alpha: 0.95)
                        : AppColorsConstant.lightNavColor.withValues(
                            alpha: 0.95,
                          ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: NavigationBar(
                        backgroundColor: themeMode
                            ? AppColorsConstant.darkNavColor.withValues(
                                alpha: 0.95,
                              )
                            : AppColorsConstant.lightNavColor.withValues(
                                alpha: 0.95,
                              ),
                        selectedIndex: selectedPage,
                        onDestinationSelected: (value) {
                          selectedPageNotifier.value = value;
                        },
                        height: 45,
                        destinations: const [
                          SizedBox(width: 60),
                          SizedBox(width: 60),
                          SizedBox(width: 60),
                          SizedBox(width: 60),
                          SizedBox(width: 60),
                          SizedBox(width: 60),
                          SizedBox(width: 60),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ///------------ The navigation items --------------------------------//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavItem(
                    icon: CupertinoIcons.house,
                    label: "Properties",
                    index: 0,
                  ),
                  NavItem(
                    icon: CupertinoIcons.money_dollar_circle,
                    label: "Finances",
                    index: 1,
                  ),
                  NavItem(
                    icon: CupertinoIcons.person_2,
                    label: "Tenants",
                    index: 2,
                  ),

                  const SizedBox(width: 70),

                  NavItem(
                    icon: CupertinoIcons.chat_bubble_2,
                    label: "Chats",
                    index: 4,
                  ),
                  NavItem(
                    icon: CupertinoIcons.gear,
                    label: "Settings",
                    index: 5,
                  ),
                  NavItem(
                    icon: CupertinoIcons.person,
                    label: "Profile",
                    index: 6,
                  ),
                ],
              ),

              /// FLOATING HOME BUTTON
              Positioned(
                top: -20,
                child: NavItem(
                  icon: CupertinoIcons.home,
                  label: "Home",
                  index: 3,
                  isHomeButton: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
