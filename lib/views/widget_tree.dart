import 'package:flutter/material.dart';
import 'package:test_app/data/notifiers.dart';
import 'package:test_app/views/pages/home_page.dart';
import 'package:test_app/views/pages/profile_page.dart';
import 'package:test_app/views/pages/settings_page.dart';
import 'package:test_app/views/widgets/navbar_widget.dart';
import 'package:test_app/views/widgets/theme_toggle_widget.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    String? title = 'Test App';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          ThemeToggleWidget(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: const [
            DrawerHeader(child: Text('Welcome')),
            ListTile(title: Text('Log Out')),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotfier,
        builder: (context, value, child) {
          return pages.elementAt(value);
        },
      ),

      bottomNavigationBar: NavbarWidget(),
    );
  }
}
