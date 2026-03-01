import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/views/pages/widget_tree/intro_row/ai_widget.dart';
import 'package:test_app/views/pages/widget_tree/intro_row/clock_widget.dart';
import 'package:test_app/views/pages/widget_tree/intro_row/notifications.dart';
import 'package:test_app/views/pages/widget_tree/intro_row/settings_icon_widget.dart';
import 'package:test_app/views/widgets/search_widget/search_widget.dart';

class IntroRowWidget extends StatefulWidget {
  const IntroRowWidget({super.key});

  @override
  State<IntroRowWidget> createState() => _IntroRowWidgetState();
}

class _IntroRowWidgetState extends State<IntroRowWidget> {
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
        // 2. Right-hand controls (AI Assistant + Icons)
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
              // 2.3 Settings icon
              SettingsIconWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
