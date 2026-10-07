// import 'package:anyamar/commons/app_colors.dart';
// import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/intro_text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DashboardPageShell extends ConsumerWidget {
//   final String introText;
//   final List<Widget> dashboardWidgets;
//   final Widget? stickyWidget;
//   final VoidCallback? onButtonPressedCallBack;
//   const DashboardPageShell({
//     super.key,
//     required this.introText,
//     required this.dashboardWidgets,
//     this.stickyWidget,
//     this.onButtonPressedCallBack,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           // Intro
//           IntroTextWidget(dashboardItem: introText),
//           SizedBox(height: 15.0),

//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       introText,
//                       style: const TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff12234A),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       'Manage all your $introText in one place.',
//                       style: TextStyle(fontSize: 14, color: Color(0xff718096)),
//                     ),
//                   ],
//                 ),
//               ),

//               ElevatedButton.icon(
//                 onPressed: onButtonPressedCallBack,
//                 icon: const Icon(Icons.add),
//                 label: Text('Add $introText'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.buttonBlueColor,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 15,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Sticky widget
//           if (stickyWidget != null) ...[
//             const SizedBox(height: 20),
//             stickyWidget!,
//           ],
//           //Sticky widget
//           // Scrollable area
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [const SizedBox(height: 10), ...dashboardWidgets],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/intro_text_widget.dart';

class DashboardPageShell extends ConsumerWidget {
  final String introText;
  final List<Widget> dashboardWidgets;
  final Widget? stickyWidget;
  final VoidCallback? onButtonPressedCallBack;

  const DashboardPageShell({
    super.key,
    required this.introText,
    required this.dashboardWidgets,
    this.stickyWidget,
    this.onButtonPressedCallBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          IntroTextWidget(
            dashboardItem: introText,
          ),

          const SizedBox(height: 15),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      introText,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff12234A),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Manage all your $introText in one place.',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff718096),
                      ),
                    ),
                  ],
                ),
              ),

              ElevatedButton.icon(
                onPressed: onButtonPressedCallBack,
                icon: const Icon(Icons.add),
                label: Text('Add $introText'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBlueColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),

          if (stickyWidget != null) ...[
            const SizedBox(height: 20),
            stickyWidget!,
          ],

          // IMPORTANT:
          // This is the only Expanded.
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              children: [
                const SizedBox(height: 10),

                ...dashboardWidgets,
              ],
            ),
          ),
        ],
      ),
    );
  }
}