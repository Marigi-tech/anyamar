import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/notifiers.dart';
import 'package:anyamar/data/providers/theme_provider.dart';

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
      valueListenable: selectedWebPageNotifier,
      builder: (context, selectedWebPage, child) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 35,
            right: 35,
            top: 0.0,
            bottom: 20.0,
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 05.0),
                decoration: BoxDecoration(
                  color: themeMode
                      ? AppColorsConstant.darkNavColor.withValues(alpha: 0.95)
                      : AppColorsConstant.kWhite7.withValues(alpha: 0.95),
                  // : AppColorsConstant.lightNavColor.withValues(alpha: 0.95),
                  // color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomNavigationItem(
                      icon: CupertinoIcons.home,
                      label: "Home",
                      index: 0,
                    ),
                    CustomNavigationItem(
                      icon: CupertinoIcons.building_2_fill,
                      label: 'Properties',
                      index: 1,
                    ),
                    CustomNavigationItem(
                      icon: CupertinoIcons.creditcard,
                      label: 'Finances',
                      index: 2,
                    ),
                    CustomNavigationItem(
                      icon: CupertinoIcons.person_3,
                      label: 'Tenants',
                      index: 3,
                    ),
                    CustomNavigationItem(
                      icon: CupertinoIcons.gear,
                      label: 'Settings',
                      index: 4,
                    ),
                    CustomNavigationItem(
                      icon: CupertinoIcons.person,
                      label: 'My Account',
                      index: 5,
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

class CustomNavigationItem extends ConsumerStatefulWidget {
  final IconData icon;
  final String label;
  final int index;

  const CustomNavigationItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
  });

  @override
  ConsumerState<CustomNavigationItem> createState() =>
      _CustomNavigationItemState();
}

class _CustomNavigationItemState extends ConsumerState<CustomNavigationItem> {
  bool isSelected = false;
  bool isHovered = false;
  @override
  void initState() {
    isSelected = selectedPageNotifier.value == widget.index ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },

      child: GestureDetector(
        onTap: () {
          selectedWebPageNotifier.value = widget.index;
          selectedSideItemNotifier.value = widget.index;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected || isHovered
                ? LinearGradient(
                    colors: isSelected
                        ? [
                            AppColorsConstant.greenColor,
                            AppColorsConstant.darkGreenColor,
                          ]
                        : [
                            AppColorsConstant.blueColor,
                            AppColorsConstant.darkBlueColor,
                          ],
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: themeIsDark ? AppColorsConstant.background : null,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                child: isHovered || isSelected
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            color: isSelected || isHovered
                                ? Colors.white
                                : null,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
