import 'package:flutter/material.dart';
import 'package:test_app/data/notifiers.dart';
import 'package:test_app/responsiveness/responsiveness.dart';
import 'package:test_app/views/pages/dashboard_pages/chats_page.dart';
import 'package:test_app/views/pages/dashboard_pages/finances_page.dart';
import 'package:test_app/views/pages/dashboard_pages/home_page.dart';
import 'package:test_app/views/pages/dashboard_pages/properties_page.dart';
import 'package:test_app/views/pages/dashboard_pages/profile_page.dart';
import 'package:test_app/views/pages/dashboard_pages/settings_page.dart';
import 'package:test_app/views/widgets/navbar_widget/navbar_widget.dart';
import 'package:test_app/views/widgets/theme_toggle_widget.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO:Place actual page list here
    List<Widget> pages = [
      PropertiesPage(),
      FinancesPage(),
      HomePage(),
      ChatsPage(),
      ProfilePage(),
    ];

    String? title = 'Anyamar ';
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
      drawer: Visibility(
        visible: Responsiveness.isDesktop(context) ? true : false,
        child: Drawer(
          child: Column(
            children: const [
              DrawerHeader(child: Text('Welcome')),
              ListTile(title: Text('Log Out')),
            ],
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotfier,
        builder: (context, value, child) {
          print('This is the value $value');

          return pages.elementAt(value);
        },
      ),

      bottomNavigationBar: Visibility(
        visible: !Responsiveness.isDesktop(context) ? true : false,
        child: NavbarWidget(),
      ),
    );
  }
}
