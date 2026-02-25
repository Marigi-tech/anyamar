import 'package:flutter/cupertino.dart';
import 'package:test_app/views/widgets/dashboard_widgets/intro_card_widget.dart';

List<Widget> introCardsList = [
  IntroCardWidget(
    cardIcon: CupertinoIcons.building_2_fill,
    cardTitle: 'Properties',
    description: '40',
  ),

  IntroCardWidget(
    cardIcon: CupertinoIcons.person_2,
    cardTitle: 'Tenants',
    description: '140',
  ),
  IntroCardWidget(
    cardIcon: CupertinoIcons.money_dollar,
    cardTitle: 'Revenue',
    description: 'ksh 12.5 M ',
  ),
  IntroCardWidget(
    cardIcon: CupertinoIcons.chat_bubble_2,
    cardTitle: 'Chats',
    description: '40',
    extraInfo: '',
  ),
];
