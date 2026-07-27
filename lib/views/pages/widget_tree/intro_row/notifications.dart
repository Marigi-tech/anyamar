import 'package:flutter/cupertino.dart';
import 'package:anyamar/constants/commons.dart';

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double>(6),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      icon: const Icon(CupertinoIcons.bell),
      onPressed: () {},
    );
  }
}
