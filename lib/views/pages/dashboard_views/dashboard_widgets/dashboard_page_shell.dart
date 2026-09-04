

import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/intro_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPageShell extends ConsumerWidget {
  final String introText;
  final List<Widget> dashboardWidgets;
  final Widget? stickyWidget;
  const DashboardPageShell({
    super.key,
    required this.introText,
    required this.dashboardWidgets,
    this.stickyWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // Intro
        IntroTextWidget(dashboardItem: introText),

        // Sticky widget
        if (stickyWidget != null) ...[
          const SizedBox(height: 20),
          stickyWidget!,
        ],

        // Scrollable area
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [const SizedBox(height: 10), ...dashboardWidgets],
            ),
          ),
        ),
      ],
    );
  }
}
