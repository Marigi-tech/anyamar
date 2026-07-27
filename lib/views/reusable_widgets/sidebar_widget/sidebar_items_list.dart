import 'package:flutter/cupertino.dart';
import 'package:anyamar/views/reusable_widgets/sidebar_widget/sidebar_item.dart';

List<SideBarItemWidget> dashboardItems = [
  //Dashboard
  SideBarItemWidget(
    index: 0,
    title: 'Dashboard',
    icon: CupertinoIcons.list_dash,
  ),
  //Properties
  SideBarItemWidget(
    index: 1,
    title: 'Properties',
    icon: CupertinoIcons.building_2_fill,
  ),
  //Finances
  SideBarItemWidget(
    index: 2,
    title: 'Finances',
    icon: CupertinoIcons.money_dollar_circle,
  ),
  //Tenants
  SideBarItemWidget(
    index: 3,
    title: 'Tenants',
    icon: CupertinoIcons.person_3_fill,
  ),

  //Settings
  SideBarItemWidget(index: 4, title: 'Settings', icon: CupertinoIcons.gear),

  //Profile
  SideBarItemWidget(index: 5, title: 'My account', icon: CupertinoIcons.person),
  //Log Out
  SideBarItemWidget(index: 6, title: 'Log Out', icon: CupertinoIcons.power),
];
