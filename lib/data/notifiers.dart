//? Value notifier - holds the data
//Value listenable builder: listens to data( dont need set state)
import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(2);
ValueNotifier<int> selectedWebPageNotifier = ValueNotifier(
  0,
); //default index is 0
ValueNotifier<bool> themeIsDarkNotifier = ValueNotifier(true);
ValueNotifier<int> selectedSideItemNotifier = ValueNotifier(0);
ValueNotifier<bool> isSidebarCollapsedNotifier = ValueNotifier(false);
ValueNotifier<String> currentTimeNotifier = ValueNotifier('');
