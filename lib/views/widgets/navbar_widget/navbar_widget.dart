import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/data/notifiers.dart';
import 'package:test_app/views/widgets/navbar_widget/navbar_item.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotfier,
      builder: (context, selectedPage, child) {
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 20, top: 20, bottom: 20),
          child: PhysicalModel(
            elevation: 20,
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Material(
                color: themeIsDarkNotifier.value == true
                    ? AppColorsConstant.darkNavColor.withValues(alpha: 0.95)
                    : AppColorsConstant.lightNavColor.withValues(alpha: 0.95),
                child: NavigationBar(
                  selectedIndex: selectedPage,
                  onDestinationSelected: (value) {
                    selectedPageNotfier.value = value;
                  },
                  height: 60.0,
                  destinations: const [
                    NavItem(
                      icon: CupertinoIcons.building_2_fill,
                      label: "Properties",
                      index: 0,
                    ),
                    NavItem(
                      icon: CupertinoIcons.money_dollar_circle,
                      label: "Finances",
                      index: 1,
                    ),
                    NavItem(
                      icon: CupertinoIcons.home,
                      label: 'Home',
                      index: 2,
                      isHomeButton: true,
                    ),
                    NavItem(
                      icon: CupertinoIcons.chat_bubble_2,
                      label: "Chats",
                      index: 3,
                    ),
                    NavItem(
                      icon: CupertinoIcons.person,
                      label: "Profile",
                      index: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
