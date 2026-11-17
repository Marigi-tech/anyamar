import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/unavailable_info/unavailable_info_model.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

//===========================================================
// INFO UNAVAILABLE OVERLAY
//===========================================================
class InfoUnavailableOverlay extends ConsumerWidget {
  final Widget child;
  final UnavailableInfoModel? unavailableInfo;

  const InfoUnavailableOverlay({
    super.key,
    this.unavailableInfo,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeIsDarkProvider);
    return Stack(
      children: [
        child,
        if (unavailableInfo != null)
          Positioned.fill(
            child: ColoredBox(
              // Stronger film makes the form recede into the background.
              color: (isDarkMode ? Colors.black : const Color(0xFF253247))
                  .withValues(alpha: 0.40),

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),

                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: 290,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          // Nearly opaque card so its content stays crisp.
                          color: isDarkMode
                              ? const Color(0xFF202B3A)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(22),

                          border: Border.all(
                            color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.18)
                                : const Color(0xFFD5DEEA),
                            width: 1.2,
                          ),

                          boxShadow: [
                            // Main shadow lifts the popup away from the form.
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.22),
                              blurRadius: 36,
                              spreadRadius: 2,
                              offset: const Offset(0, 16),
                            ),

                            // Subtle outline glow separates the card's edges.
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.white.withValues(alpha: 0.035)
                                  : Colors.white.withValues(alpha: 0.8),
                              blurRadius: 1,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                tooltip: 'Close',
                                onPressed: unavailableInfo!.closeMethod,

                                icon: Icon(
                                  Icons.close_rounded,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : const Color(0xFF667085),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Lottie.asset('assets/lotties/login.json'),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              unavailableInfo!.text,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF253247),
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              unavailableInfo!.supplementaryText,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    height: 1.5,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : const Color(0xFF667085),
                                  ),
                            ),
                            const SizedBox(height: 25),
                            unavailableInfo!.ctaButtonWidget,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// class InfoUnavailableLottie extends StatelessWidget {
//   final bool isVisible;
//   final Widget child;
//   final Widget ctaButtonWidget;
//   final String text;
//   final bool isDarkMode;

//   const InfoUnavailableLottie({
//     super.key,
//     required this.isVisible,
//     required this.child,
//     required this.ctaButtonWidget,
//     required this.text,
//     required this.isDarkMode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (!isVisible) return child;

//     final primaryColor = Theme.of(context).colorScheme.primary;

//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         // Background: the actual tenant form remains visible.
//         child,

//         // Full-area film, separate from the popup card.
//         Positioned.fill(
//           child: ClipRect(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
//               child: ColoredBox(
//                 color: (isDarkMode ? Colors.black : const Color(0xFF253247))
//                     .withValues(alpha: 0.42),
//               ),
//             ),
//           ),
//         ),

//         // Foreground: only the card is centered.
//         Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 390),
//               child: Container(
//                 width: 390,
//                 padding: const EdgeInsets.fromLTRB(26, 12, 26, 26),
//                 decoration: BoxDecoration(
//                   color: isDarkMode ? const Color(0xFF202B3A) : Colors.white,
//                   borderRadius: BorderRadius.circular(22),
//                   border: Border.all(
//                     color: primaryColor.withValues(
//                       alpha: isDarkMode ? 0.45 : 0.22,
//                     ),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withValues(alpha: 0.28),
//                       blurRadius: 36,
//                       spreadRadius: 2,
//                       offset: const Offset(0, 14),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: IconButton(
//                         tooltip: 'Close',
//                         onPressed: () {
//                           Navigator.of(context).maybePop();
//                         },
//                         icon: Icon(
//                           Icons.close_rounded,
//                           color: isDarkMode
//                               ? Colors.white70
//                               : const Color(0xFF667085),
//                         ),
//                       ),
//                     ),

//                     Container(
//                       width: 120,
//                       height: 120,
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: primaryColor.withValues(alpha: 0.09),
//                       ),
//                       child: Lottie.asset(
//                         'assets/lotties/login.json',
//                         fit: BoxFit.contain,
//                         repeat: true,
//                       ),
//                     ),

//                     const SizedBox(height: 22),

//                     Text(
//                       text,
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: isDarkMode
//                             ? Colors.white
//                             : const Color(0xFF253247),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     Text(
//                       text,
//                       textAlign: TextAlign.center,
//                       style: CustomTextStyles.cardDescriptionStyle.copyWith(
//                         fontSize: 14,
//                         height: 1.6,
//                         color: isDarkMode
//                             ? Colors.white70
//                             : const Color(0xFF667085),
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     SizedBox(width: double.infinity, child: ctaButtonWidget),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class InfoUnavailsableLottie extends ConsumerWidget {
//   final Widget ctaButtonWidget;
//   final String text;
//   const InfoUnavailableLottie({
//     required this.ctaButtonWidget,
//     required this.text,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(maxWidth: 600),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               text,
//               style: CustomTextStyles.cardDescriptionStyle.copyWith(
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 15),
//             Lottie.asset('assets/lotties/login.json', height: 170),

//             SizedBox(height: 15),
//             ctaButtonWidget,
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:ui';

// class InfoUnavailableLottie extends ConsumerWidget {
//   final bool isVisible;
//   final Widget child;
//   final Widget ctaButtonWidget;
//   final String text;
//   final bool isDarkMode;

//   const InfoUnavailableLottie({
//     super.key,
//     required this.isVisible,
//     required this.child,
//     required this.ctaButtonWidget,
//     required this.text,
//     required this.isDarkMode,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final primaryColor = Theme.of(context).colorScheme.primary;

//     return Stack(
//       children: [
//         // The existing dashboard remains underneath.
//         child,

//         if (isVisible)
//           Positioned.fill(
//             child: ColoredBox(
//               color: (isDarkMode ? Colors.black : Colors.white).withValues(
//                 alpha: 0.25,
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                   child: Container(
//                     width: 380,
//                     height: 500,
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: isDarkMode
//                           ? const Color(0xFF252F3D).withValues(alpha: 0.95)
//                           : Colors.white.withValues(alpha: 0.95),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: isDarkMode
//                             ? Colors.white.withValues(alpha: 0.12)
//                             : const Color(0xFFDCE4EE),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.08),
//                           blurRadius: 24,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Close button
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: IconButton(
//                               tooltip: 'Close',
//                               onPressed: () {
//                                 Navigator.of(context).maybePop();
//                               },
//                               icon: Icon(
//                                 Icons.close_rounded,
//                                 color: isDarkMode
//                                     ? Colors.white70
//                                     : const Color(0xFF667085),
//                               ),
//                             ),
//                           ),

//                           // Lottie animation
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: primaryColor.withValues(alpha: 0.08),
//                             ),
//                             child: Lottie.asset(
//                               'assets/lotties/login.json',
//                               height: 145,
//                               repeat: true,
//                               fit: BoxFit.contain,
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // Accent divider
//                           Container(
//                             height: 4,
//                             width: 42,
//                             decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),

//                           const SizedBox(height: 18),

//                           Text(
//                             text,
//                             textAlign: TextAlign.center,
//                             style: CustomTextStyles.cardDescriptionStyle
//                                 .copyWith(
//                                   fontSize: 16,
//                                   height: 1.6,
//                                   fontWeight: FontWeight.w500,
//                                   color: isDarkMode
//                                       ? Colors.white
//                                       : const Color(0xFF253247),
//                                 ),
//                           ),

//                           const SizedBox(height: 26),

//                           Row(
//                             children: [
//                               ElevatedButtonWidget(
//                                 buttonTitle: 'Back',
//                                 onButtonPressedCallBack: () => ref
//                                     .read(workspaceProvider.notifier)
//                                     .closeWorkspace(),
//                               ),
//                               SizedBox(child: ctaButtonWidget),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
        // Positioned.fill(
        //   child: Material(
        //     color: Colors.transparent,
        //     child: ColoredBox(
        //       color: (isDarkMode ? Colors.black : Colors.white).withValues(
        //         alpha: 0.30,
        //       ),
        //       child: SingleChildScrollView(
        //         padding: const EdgeInsets.all(20),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(24),
        //           child: BackdropFilter(
        //             filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        //             child: Container(
        //               width: 380,
        //               constraints: const BoxConstraints(maxWidth: 460),
        //               padding: const EdgeInsets.fromLTRB(26, 12, 26, 28),
        //               decoration: BoxDecoration(
        //                 gradient: LinearGradient(
        //                   begin: Alignment.topLeft,
        //                   end: Alignment.bottomRight,
        //                   colors: isDarkMode
        //                       ? [
        //                           const Color(
        //                             0xFF252F3D,
        //                           ).withValues(alpha: 0.98),
        //                           const Color(
        //                             0xFF1B2431,
        //                           ).withValues(alpha: 0.97),
        //                         ]
        //                       : [
        //                           Colors.white.withValues(alpha: 0.98),
        //                           const Color(
        //                             0xFFF6F9FD,
        //                           ).withValues(alpha: 0.97),
        //                         ],
        //                 ),
        //                 borderRadius: BorderRadius.circular(24),
        //                 border: Border.all(
        //                   color: primaryColor.withValues(
        //                     alpha: isDarkMode ? 0.35 : 0.20,
        //                   ),
        //                 ),
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.black.withValues(
        //                       alpha: isDarkMode ? 0.24 : 0.10,
        //                     ),
        //                     blurRadius: 30,
        //                     offset: const Offset(0, 12),
        //                   ),
        //                 ],
        //               ),
        //               child: Column(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   // Close button
        //                   Align(
        //                     alignment: Alignment.topRight,
        //                     child: IconButton(
        //                       tooltip: 'Close',
        //                       onPressed: () {
        //                         Navigator.of(context).maybePop();
        //                       },
        //                       icon: Icon(
        //                         Icons.close_rounded,
        //                         color: isDarkMode
        //                             ? Colors.white70
        //                             : const Color(0xFF667085),
        //                       ),
        //                     ),
        //                   ),

        //                   // Lottie animation
        //                   Container(
        //                     padding: const EdgeInsets.all(10),
        //                     decoration: BoxDecoration(
        //                       shape: BoxShape.circle,
        //                       color: primaryColor.withValues(alpha: 0.08),
        //                     ),
        //                     child: Lottie.asset(
        //                       'assets/lotties/login.json',
        //                       height: 145,
        //                       repeat: true,
        //                       fit: BoxFit.contain,
        //                     ),
        //                   ),

        //                   const SizedBox(height: 20),

        //                   // Accent divider
        //                   Container(
        //                     height: 4,
        //                     width: 42,
        //                     decoration: BoxDecoration(
        //                       color: primaryColor,
        //                       borderRadius: BorderRadius.circular(10),
        //                     ),
        //                   ),

        //                   const SizedBox(height: 18),

        //                   Text(
        //                     text,
        //                     textAlign: TextAlign.center,
        //                     style: CustomTextStyles.cardDescriptionStyle
        //                         .copyWith(
        //                           fontSize: 16,
        //                           height: 1.6,
        //                           fontWeight: FontWeight.w500,
        //                           color: isDarkMode
        //                               ? Colors.white
        //                               : const Color(0xFF253247),
        //                         ),
        //                   ),

        //                   const SizedBox(height: 26),

        //                   Row(
        //                     children: [
        //                       ClearButtonWidget(
        //                         title: 'Back',
        //                         onPressedCallBack: () => ref
        //                             .read(workspaceProvider.notifier)
        //                             .closeWorkspace(),
        //                       ),
        //                       SizedBox(child: ctaButtonWidget),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
//       ],
//     );
//   }
// }
