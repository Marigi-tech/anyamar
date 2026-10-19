import 'package:anyamar/commons/exports.dart';
import 'dart:ui';

class FormCardWidget extends ConsumerWidget {
  final double? noOfColumnsPerRow;
  final IconData? formTitleIcon;
  final String? formCardTitle;
  final List<Widget> formInputs;
  final Widget? supplementaryInfoWidget;

  const FormCardWidget({
    super.key,
    required this.noOfColumnsPerRow,
    this.formCardTitle,
    required this.formInputs,
    this.formTitleIcon,
    this.supplementaryInfoWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final isDark = themeIsDark == true;

    const accentColor = AppColors.primaryBlue;

    final titleColor = isDark ? Colors.white : AppColors.buttonBlueColor;

    final glassBorderColor = isDark
        ? Colors.white.withValues(alpha: 0.22)
        : Colors.white.withValues(alpha: 0.95);

    final glassColors = isDark
        ? [
            const Color(0xFF263B53).withValues(alpha: 0.96),
            const Color(0xFF111D2D).withValues(alpha: 0.92),
          ]
        : [
            Colors.white.withValues(alpha: 0.98),
            const Color(0xFFEAF3FF).withValues(alpha: 0.94),
          ];

    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.24)
        : const Color(0xFF64748B).withValues(alpha: 0.10);

    final glowColor = accentColor.withValues(alpha: isDark ? 0.18 : 0.12);

    return LayoutBuilder(
      builder: (context, outerConstraints) {
        final screenWidth = outerConstraints.maxWidth;

        final horizontalPadding = screenWidth >= 900
            ? 32.0
            : screenWidth >= 600
            ? 24.0
            : 16.0;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: glassColors,
            ),
            border: Border.all(color: glassBorderColor, width: 1.4),
            boxShadow: [
              // Blue ambient glow
              BoxShadow(
                color: glowColor,
                blurRadius: 30,
                spreadRadius: -3,
                offset: const Offset(0, 12),
              ),

              // Soft elevation shadow
              BoxShadow(
                color: shadowColor,
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            const Color(0xFF263B53).withValues(alpha: 0.76),
                            const Color(0xFF263B53).withValues(alpha: 0.76),
                            // const Color(0xFF162438).withValues(alpha: 0.58),
                            const Color(0xFF263B53).withValues(alpha: 0.76),
                            const Color(0xFF263B53).withValues(alpha: 0.76),
                            // const Color(0xFF0F1B2B).withValues(alpha: 0.78),
                          ]
                        : [
                            // Colors.white.withValues(alpha: 0.86),
                            // const Color(0xFFF1F7FF).withValues(alpha: 0.66),
                            const Color.fromARGB(
                              255,
                              227,
                              234,
                              241,
                            ).withValues(alpha: 0.78),
                            const Color.fromARGB(
                              255,
                              227,
                              234,
                              241,
                            ).withValues(alpha: 0.78),
                            const Color.fromARGB(
                              255,
                              227,
                              234,
                              241,
                            ).withValues(alpha: 0.78),
                          ],
                  ),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.10)
                        : Colors.white.withValues(alpha: 0.65),
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    // Glass reflection along the upper edge.
                    // Positioned(
                    //   top: 0,
                    //   left: 24,
                    //   right: 24,
                    //   child: Container(
                    //     height: 1,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white.withValues(
                    //         alpha: isDark ? 0.40 : 0.98,
                    //       ),
                    //       // gradient: LinearGradient(
                    //       //   colors: [
                    //       //     Colors.transparent,
                    //       //     Colors.white.withValues(
                    //       //       alpha: isDark ? 0.40 : 0.98,
                    //       //     ),
                    //       //     accentColor.withValues(alpha: 0.22),
                    //       //     Colors.transparent,
                    //       //   ],
                    //       // ),
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        26,
                        horizontalPadding,
                        26,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (formCardTitle != null) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 46,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        accentColor.withValues(alpha: 0.24),
                                        accentColor.withValues(alpha: 0.07),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: accentColor.withValues(
                                        alpha: 0.28,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: accentColor.withValues(
                                          alpha: 0.10,
                                        ),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    formTitleIcon ?? Icons.edit_note_rounded,
                                    size: 24,
                                    color: accentColor,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    formCardTitle!,
                                    style: CustomTextStyles.cardDescriptionStyle
                                        .copyWith(
                                          color: titleColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: -0.3,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            supplementaryInfoWidget ?? SizedBox.shrink(),

                            const SizedBox(height: 22),

                            // Subtle reflective divider.
                            // CustomDividerWidget(),
                            Container(
                              height: 0.4,
                              decoration: BoxDecoration(
                                color: !isDark
                                    ? AppColors.darkBorder
                                    : AppColors.lightBorder,
                              ),
                            ),
                            //     // gradient: LinearGradient(
                            //     //   colors: [
                            //     //     glassBorderColor,
                            //     //     Colors.transparent,
                            //     //     Colors.transparent,
                            //     //     Colors.transparent,
                            //     //     Colors.transparent,
                            //     //     glassBorderColor,
                            //     //     // glassBorderColor,
                            //     //     // glassBorderColor,
                            //     //     // glassBorderColor,
                            //     //     // accentColor.withValues(alpha: 0.16),
                            //     //     // Colors.transparent,
                            //     //   ],
                            //     // ),
                            //   ),
                            // ),
                            const SizedBox(height: 26),
                          ],

                          LayoutBuilder(
                            builder: (context, constraints) {
                              const spacing = 20.0;
                              const runSpacing = 22.0;

                              final width = constraints.maxWidth;

                              final columns = width >= 900
                                  ? (noOfColumnsPerRow ?? 3).round().clamp(1, 4)
                                  : width >= 600
                                  ? (noOfColumnsPerRow ?? 2).round().clamp(1, 3)
                                  : 1;

                              final itemWidth = columns == 1
                                  ? width
                                  : (width - spacing * (columns - 1)) / columns;

                              return Wrap(
                                spacing: spacing,
                                runSpacing: runSpacing,
                                children: [
                                  for (final child in formInputs)
                                    SizedBox(width: itemWidth, child: child),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class FormCardWidget extends ConsumerWidget {
//   final double? noOfColumnsPerRow;
//   final IconData? formTitleIcon;
//   final String? formCardTitle;
//   final List<Widget> formInputs;

//   const FormCardWidget({
//     super.key,
//     required this.noOfColumnsPerRow,
//     this.formCardTitle,
//     required this.formInputs,
//     this.formTitleIcon,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeIsDark = ref.watch(themeIsDarkProvider);
//     final isDark = themeIsDark == true;

//     const accentColor = AppColors.primaryBlue;

//     final borderColor = isDark
//         ? Colors.white.withValues(alpha: 0.14)
//         : Colors.white.withValues(alpha: 0.75);

//     final shadowColor = isDark
//         ? Colors.black.withValues(alpha: 0.16)
//         : const Color(0xFF64748B).withValues(alpha: 0.08);

//     final titleColor = isDark ? Colors.white : AppColors.buttonBlueColor;

//     final glassTint = isDark
//         ? const Color(0xFF182536).withValues(alpha: 0.72)
//         : Colors.white.withValues(alpha: 0.68);

//     return LayoutBuilder(
//       builder: (context, outerConstraints) {
//         final screenWidth = outerConstraints.maxWidth;

//         final horizontalPadding = screenWidth >= 900
//             ? 32.0
//             : screenWidth >= 600
//             ? 24.0
//             : 16.0;

//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(22),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: isDark
//                   ? [
//                       const Color(0xFF253A52).withValues(alpha: 0.96),
//                       const Color(0xFF111D2D).withValues(alpha: 0.92),
//                     ]
//                   : [
//                       Colors.white.withValues(alpha: 0.96),
//                       const Color(0xFFEAF3FF).withValues(alpha: 0.90),
//                     ],
//             ),
//             border: Border.all(
//               color: isDark
//                   ? Colors.white.withValues(alpha: 0.22)
//                   : Colors.white.withValues(alpha: 0.95),
//               width: 1.4,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.primaryBlue.withValues(
//                   alpha: isDark ? 0.16 : 0.10,
//                 ),
//                 blurRadius: 30,
//                 spreadRadius: -3,
//                 offset: const Offset(0, 12),
//               ),
//               BoxShadow(
//                 color: isDark
//                     ? Colors.black.withValues(alpha: 0.24)
//                     : const Color(0xFF64748B).withValues(alpha: 0.10),
//                 blurRadius: 18,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),
//           // decoration: BoxDecoration(
//           //   borderRadius: BorderRadius.circular(20),
//           //   border: Border.all(color: borderColor, width: 1.1),
//           //   boxShadow: [
//           //     BoxShadow(
//           //       color: shadowColor,
//           //       blurRadius: 24,
//           //       spreadRadius: 0,
//           //       offset: const Offset(0, 8),
//           //     ),
//           //   ],
//           // ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(22),
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: isDark
//                         ? [
//                             const Color(0xFF263B53).withValues(alpha: 0.72),
//                             const Color(0xFF162438).withValues(alpha: 0.48),
//                             const Color(0xFF0F1B2B).withValues(alpha: 0.72),
//                           ]
//                         : [
//                             Colors.white.withValues(alpha: 0.78),
//                             const Color(0xFFF1F7FF).withValues(alpha: 0.52),
//                             const Color(0xFFE1EDFC).withValues(alpha: 0.70),
//                           ],
//                   ),
//                   border: Border.all(
//                     color: isDark
//                         ? Colors.white.withValues(alpha: 0.10)
//                         : Colors.white.withValues(alpha: 0.65),
//                   ),
//                 ),
//                 // decoration: BoxDecoration(
//                 //   gradient: LinearGradient(
//                 //     begin: Alignment.topLeft,
//                 //     end: Alignment.bottomRight,
//                 //     colors: [
//                 //       glassTint,
//                 //       glassTint.withValues(alpha: isDark ? 0.58 : 0.42),
//                 //     ],
//                 //   ),
//                 //   borderRadius: BorderRadius.circular(20),
//                 //   border: Border.all(
//                 //     color: isDark
//                 //         ? Colors.white.withValues(alpha: 0.035)
//                 //         : Colors.white.withValues(alpha: 0.45),
//                 //   ),
//                 // ),
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(
//                     horizontalPadding,
//                     24,
//                     horizontalPadding,
//                     24,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (formCardTitle != null) ...[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 44,
//                               height: 44,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     accentColor.withValues(alpha: 0.20),
//                                     accentColor.withValues(alpha: 0.07),
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(14),
//                                 border: Border.all(
//                                   color: accentColor.withValues(alpha: 0.18),
//                                 ),
//                               ),
//                               alignment: Alignment.center,
//                               child: Icon(
//                                 formTitleIcon ?? Icons.edit_note_rounded,
//                                 size: 23,
//                                 color: accentColor,
//                               ),
//                             ),
//                             const SizedBox(width: 14),
//                             Expanded(
//                               child: Text(
//                                 formCardTitle!,
//                                 style: CustomTextStyles.cardDescriptionStyle
//                                     .copyWith(
//                                       color: titleColor,
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.w600,
//                                       letterSpacing: -0.3,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 22),

//                         // Subtle glass divider
//                         Container(
//                           height: 1,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.transparent,
//                                 borderColor,
//                                 borderColor.withValues(alpha: 0.25),
//                                 Colors.transparent,
//                               ],
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 26),
//                       ],

//                       LayoutBuilder(
//                         builder: (context, constraints) {
//                           const spacing = 20.0;
//                           const runSpacing = 22.0;

//                           final width = constraints.maxWidth;

//                           final columns = width >= 900
//                               ? (noOfColumnsPerRow ?? 3).round().clamp(1, 4)
//                               : width >= 600
//                               ? (noOfColumnsPerRow ?? 2).round().clamp(1, 3)
//                               : 1;

//                           final itemWidth = columns == 1
//                               ? width
//                               : (width - spacing * (columns - 1)) / columns;

//                           return Wrap(
//                             spacing: spacing,
//                             runSpacing: runSpacing,
//                             children: [
//                               for (final child in formInputs)
//                                 SizedBox(width: itemWidth, child: child),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class FormCardWidget extends ConsumerWidget {
//   final double? noOfColumnsPerRow;
//   final IconData? formTitleIcon;
//   final String? formCardTitle;
//   final List<Widget> formInputs;

//   const FormCardWidget({
//     super.key,
//     required this.noOfColumnsPerRow,
//     this.formCardTitle,
//     required this.formInputs,
//     this.formTitleIcon,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeIsDark = ref.watch(themeIsDarkProvider);
//     final isDark = themeIsDark == true;

//     const accentColor = AppColors.primaryBlue;

//     final cardColor = isDark
//         ? AppColors.darkElevatedCard
//         : AppColors.whiteColor;

//     final borderColor = isDark ? AppColors.darkBorder : const Color(0xFFE5EAF1);

//     final titleColor = isDark ? Colors.white : AppColors.buttonBlueColor;

//     return LayoutBuilder(
//       builder: (context, outerConstraints) {
//         final screenWidth = outerConstraints.maxWidth;

//         final horizontalPadding = screenWidth >= 900
//             ? 32.0
//             : screenWidth >= 600
//             ? 24.0
//             : 16.0;

//         return Card(
//           elevation: isDark ? 0 : 1.5,
//           color: cardColor,
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           clipBehavior: Clip.antiAlias,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//             side: BorderSide(color: borderColor),
//           ),
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//               horizontalPadding,
//               24,
//               horizontalPadding,
//               8,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (formCardTitle != null) ...[
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 42,
//                         height: 42,
//                         decoration: BoxDecoration(
//                           color: accentColor.withValues(alpha: 0.10),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         alignment: Alignment.center,
//                         child: Icon(
//                           formTitleIcon ?? Icons.edit_note_rounded,
//                           size: 22,
//                           color: accentColor,
//                         ),
//                       ),
//                       const SizedBox(width: 14),
//                       Expanded(
//                         child: Text(
//                           formCardTitle!,
//                           style: CustomTextStyles.cardDescriptionStyle.copyWith(
//                             color: titleColor,
//                             fontSize: 17,
//                             fontWeight: FontWeight.normal,
//                             letterSpacing: -0.2,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Divider(height: 1, thickness: 1, color: borderColor),
//                   const SizedBox(height: 24),
//                 ],
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     const spacing = 20.0;
//                     const runSpacing = 22.0;

//                     final width = constraints.maxWidth;

//                     final columns = width >= 900
//                         ? (noOfColumnsPerRow ?? 3).round().clamp(1, 4)
//                         : width >= 600
//                         ? (noOfColumnsPerRow ?? 2).round().clamp(1, 3)
//                         : 1;

//                     final itemWidth = columns == 1
//                         ? width
//                         : (width - spacing * (columns - 1)) / columns;

//                     return Wrap(
//                       spacing: spacing,
//                       runSpacing: runSpacing,
//                       children: [
//                         for (final child in formInputs)
//                           SizedBox(width: itemWidth, child: child),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class FormCardWidget extends ConsumerWidget {
//   final double? noOfColumnsPerRow;
//   final IconData? formTitleIcon;
//   final String? formCardTitle;
//   final List<Widget> formInputs;
//   const FormCardWidget({
//     super.key,
//     required this.noOfColumnsPerRow,
//     this.formCardTitle,
//     required this.formInputs,
//     this.formTitleIcon,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeIsDark = ref.read(themeIsDarkProvider);
//     double spacing = 14;
//     double runSpacing = 18;
//     return Card(
//       elevation: 6.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(
//           color: themeIsDark == true
//               ? AppColors.darkBorder
//               : const Color(0xffE5EAF1),
//         ),
//       ),

//       color: themeIsDark == true
//           ? AppColors.darkElevatedCard
//           : AppColors.whiteColor,

//       child: Padding(
//         padding: EdgeInsets.only(
//           left: 50.0,
//           right: 50.0,
//           top: 20.0,
//           bottom: 40.0,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (formCardTitle != null)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   if (formTitleIcon != null)
//                     Icon(formTitleIcon, size: 18, color: AppColors.primaryBlue),
//                   if (formTitleIcon != null) SizedBox(width: 10),
//                   Text(
//                     formCardTitle!,
//                     style: CustomTextStyles.cardDescriptionStyle.copyWith(
//                       color: AppColors.buttonBlueColor,
//                       fontStyle: FontStyle.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             if (formCardTitle != null) SizedBox(height: 20),
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 final width = constraints.maxWidth;

//                 final columns = width >= 1100
//                     ? noOfColumnsPerRow ?? 2
//                     : width >= 700
//                     ? noOfColumnsPerRow ?? 2
//                     : 1;

//                 final itemWidth = (width - ((columns - 1) * spacing)) / columns;

//                 return Wrap(
//                   spacing: spacing,
//                   runSpacing: runSpacing,
//                   children: [
//                     for (final child in formInputs)
//                       SizedBox(width: itemWidth, child: child),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
