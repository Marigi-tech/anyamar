import 'package:flutter/cupertino.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/sidebar_widget/sidebar_item.dart';
import 'package:flutter/material.dart';

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
    //Units
  SideBarItemWidget(
    index: 2,
    title: 'Units',
    icon: Icons.house,
  ),
    //Tenants
  SideBarItemWidget(
    index: 3,
    title: 'Tenants',
    icon: CupertinoIcons.person_3_fill,
  ),
  //Payments
  SideBarItemWidget(
    index: 4,
    title: 'Payments',
    icon: Icons.wallet,
  ),
   //Rental Income
  SideBarItemWidget(
    index: 5,
    title: 'Rental Income',
    icon: CupertinoIcons.money_dollar_circle,
  ),


  //Settings
  SideBarItemWidget(index: 6, title: 'Settings', icon: CupertinoIcons.gear),

  //Profile
  SideBarItemWidget(index: 7, title: 'My account', icon: CupertinoIcons.person),
  //Log Out
];
