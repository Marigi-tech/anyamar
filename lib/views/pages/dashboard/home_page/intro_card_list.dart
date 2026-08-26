import 'package:anyamar/data/notifiers.dart';
import 'package:flutter/cupertino.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_widgets/intro_card_widget.dart';

List<Widget> introCardsList = [
  IntroCardWidget(
    cardIcon: CupertinoIcons.building_2_fill,
    cardTitle: 'Properties',
    description: '40',
    onPressedCallBack: () {
      selectedWebPageNotifier.value = 1;
      selectedSideItemNotifier.value = 1;
    },
  ),

  IntroCardWidget(
    cardIcon: CupertinoIcons.person_2,
    cardTitle: 'Tenants',
    description: '140',
    onPressedCallBack: () {
      selectedWebPageNotifier.value = 3;
      selectedSideItemNotifier.value = 3;
    },
  ),
  IntroCardWidget(
    cardIcon: CupertinoIcons.money_dollar,
    cardTitle: 'Revenue',
    description: 'ksh 12.5 M ',
    onPressedCallBack: () {
      selectedWebPageNotifier.value = 2;
      selectedSideItemNotifier.value = 2;
    },
  ),
  IntroCardWidget(
    cardIcon: CupertinoIcons.person,
    cardTitle: 'My Account',
    description: '',
    extraInfo: '',
    onPressedCallBack: () {
      selectedWebPageNotifier.value = 5;
      selectedSideItemNotifier.value = 5;
    },
  ),
];
