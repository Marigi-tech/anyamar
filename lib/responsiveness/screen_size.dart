import 'package:flutter/widgets.dart';

///
/// @param context
/// @returns Size object containing the size of the device's screen
///
Size getSizeFromContext(BuildContext context) {
  return MediaQuery.of(context).size;
}
