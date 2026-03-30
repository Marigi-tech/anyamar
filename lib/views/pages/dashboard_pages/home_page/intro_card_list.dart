import 'package:flutter/cupertino.dart';
import 'package:test_app/views/dashboard_widgets/intro_card_widget.dart';

List<Widget> introCardsList = [
  IntroCardWidget(
    cardIcon: CupertinoIcons.building_2_fill,
    cardTitle: 'Properties',
    description: '40',

    onPressedCallBack: () {},
  ),

  IntroCardWidget(
    cardIcon: CupertinoIcons.person_2,
    cardTitle: 'Tenants',
    description: '140',
    onPressedCallBack: () {},
  ),
  IntroCardWidget(
    cardIcon: CupertinoIcons.money_dollar,
    cardTitle: 'Revenue',
    description: 'ksh 12.5 M ',
    onPressedCallBack: () {},
  ),
  IntroCardWidget(
    cardIcon: CupertinoIcons.chat_bubble_2,
    cardTitle: 'Chats',
    description: '40',
    extraInfo: '',
    onPressedCallBack: () {},
  ),
];
