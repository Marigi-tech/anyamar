import 'package:flutter/cupertino.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/sidebar_widget/sidebar_item.dart';
import 'package:flutter/material.dart';

List<SideBarItemWidget> dashboardItems = [
  //Dashboard
  SideBarItemWidget(
    index: 0,
    title: 'Dashboard',
    icon: Icons.dashboard_outlined,
  ),
  //Properties
  SideBarItemWidget(
    index: 1,
    title: 'Properties',
    icon: Icons.apartment_outlined,
  ),
  //Units
  SideBarItemWidget(index: 2, title: 'Units', icon: Icons.home_work_outlined),
  //Tenants
  SideBarItemWidget(index: 3, title: 'Tenants', icon: Icons.people),
  //Payments
  SideBarItemWidget(
    index: 4,
    title: 'Payments',
    icon: Icons.account_balance_wallet_outlined,
  ),
  //Rental Income
  // SideBarItemWidget(
  //   index: 5,
  //   title: 'Rental Reports',
  //   icon: Icons.bar_chart_outlined,
  // ),

  //Settings
  SideBarItemWidget(index: 5, title: 'Settings', icon: CupertinoIcons.gear),

  //Profile
  SideBarItemWidget(index: 6, title: 'My account', icon: CupertinoIcons.person),

  //
];
