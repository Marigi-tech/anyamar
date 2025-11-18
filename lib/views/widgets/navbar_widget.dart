import 'package:flutter/material.dart';
import 'package:test_app/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotfier,
      builder: (context, selectedPage, child) => NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedIndex: selectedPage,
        onDestinationSelected: (value) {
          selectedPageNotfier.value = value;
        },
      ),
    );
  }
}
