import 'package:flutter/cupertino.dart';
import 'package:test_app/views/widgets/sidebar_widget/sidebar_item.dart';

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
  //Chats
  SideBarItemWidget(
    index: 4,
    title: 'Chats',
    icon: CupertinoIcons.chat_bubble_2,
  ),
  //Settings
  SideBarItemWidget(index: 5, title: 'Settings', icon: CupertinoIcons.gear),

  //Profile
  SideBarItemWidget(index: 6, title: 'My account', icon: CupertinoIcons.person),
  //Log Out
  SideBarItemWidget(index: 7, title: 'Log Out', icon: CupertinoIcons.power),
];
