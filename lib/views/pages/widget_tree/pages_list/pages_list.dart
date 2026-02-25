import 'package:flutter/material.dart';
import 'package:test_app/views/pages/dashboard_pages/chats_page/chats_page.dart';
import 'package:test_app/views/pages/dashboard_pages/finances_page/finances_page.dart';
import 'package:test_app/views/pages/dashboard_pages/home_page/home_page.dart';
import 'package:test_app/views/pages/dashboard_pages/profile_page/profile_page.dart';
import 'package:test_app/views/pages/dashboard_pages/properties_page/properties_page.dart';
import 'package:test_app/views/pages/dashboard_pages/settings_page/settings_page.dart';
import 'package:test_app/views/pages/dashboard_pages/tenants_page/tenants_page.dart';

final List<Widget> pages = [
  PropertiesPage(),
  FinancesPage(),
  TenantsPage(),
  HomePage(),
  ChatsPage(),
  SettingsPage(),
  ProfilePage(),
];

final List<Widget> webPages = [
  HomePage(),
  PropertiesPage(),
  FinancesPage(),
  TenantsPage(),
  ChatsPage(),
  SettingsPage(),
  ProfilePage(),
];
