import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/ai_widget.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/clock_widget.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/notifications.dart';
import 'package:anyamar/views/pages/widget_tree/intro_row/welcome_text.dart';

import 'package:anyamar/views/reusable_widgets/search_widget/search_widget.dart';

class IntroRowWidget extends StatelessWidget {
  const IntroRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 1. Search Field (Wrapped in Flexible)
        SearchWidget(),
        // Time
        Visibility(
          visible: !Responsiveness.isMobile(context) ? true : false,
          child: ClockWidget(),
        ),
        //2 User Name
        Visibility(
          visible: !Responsiveness.isMobile(context) ? true : false,
          child: UserNameText(),
        ),
        // 2 . Right-hand controls (AI Assistant + Icons)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              // 2.1) AI Assistant Card (already compact)
              AiWidget(),
              const SizedBox(width: 6.0),
              // 2.2)  Notification icon
              NotificationIconWidget(),
              const SizedBox(width: 6.0),
              // 2.3 Theme Icon widget
              ThemeToggleWidget(),
              // SettingsIconWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
