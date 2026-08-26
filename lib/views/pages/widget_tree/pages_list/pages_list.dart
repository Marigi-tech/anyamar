import 'package:flutter/material.dart';
import 'package:anyamar/views/pages/dashboard/chats/chats_page.dart';
import 'package:anyamar/views/pages/dashboard/home_page/home_page.dart';
import 'package:anyamar/views/pages/dashboard/finances/finances_page.dart';
import 'package:anyamar/views/pages/dashboard/profile_page/profile_page.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/properties_page.dart';
import 'package:anyamar/views/pages/dashboard/settings_page/settings_page.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/tenants_page.dart';

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
  // ChatsPage(),
  SettingsPage(),
  ProfilePage(),
];
