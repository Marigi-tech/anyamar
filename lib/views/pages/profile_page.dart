import 'package:flutter/material.dart';
import 'package:test_app/data/notifiers.dart';
import 'package:test_app/views/pages/initial_pages/landing_page/landing_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Log out'),
            onTap: () {
              selectedPageNotfier.value = 0;
              themeIsDarkNotifier.value = true;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LandingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
