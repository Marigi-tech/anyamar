import 'package:anyamar/commons/exports.dart';

class SummaryCard extends ConsumerWidget {
  final IconData? icon;
  final String? title;
  final String? value;
  final String? subtitle;
  final Color? iconCardColor;
  final double? fontSize;
  final VoidCallback? onPressedCallBack;
  final Widget? isChartWidget;

  const SummaryCard({
    super.key,
    this.icon,
    this.title,
    this.value,
    this.subtitle,
    this.onPressedCallBack,
    this.fontSize,
    this.iconCardColor,
    this.isChartWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressedCallBack,
        child: Container(
          width: double.infinity,
          height: 115,
          padding: const EdgeInsets.only(
            left: 10,
            top: 16,
            right: 25,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            color: themeIsDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: themeIsDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
          child:
              isChartWidget ??
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // --------------------------------------------------
                  // Icon
                  // --------------------------------------------------
                  SizedBox(
                    width: 38,
                    height: 38,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        // color: iconCardColor,
                        color: iconCardColor != null
                            ? iconCardColor!.withValues(alpha: 0.2)
                            : AppColors.primaryBlue.withValues(alpha: 0.2),
                        // color: themeIsDark == true
                        //     ? AppColors.darkBorder
                        //     : Color(0xffEDF3FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 17, color: iconCardColor),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // --------------------------------------------------
                  // Text
                  // --------------------------------------------------
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.cardDescriptionStyle
                                .copyWith(
                                  fontSize: 14,
                                  color: Color(0xff718096),
                                  fontStyle: FontStyle.normal,
                                ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            value ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.cardDescriptionStyle
                                .copyWith(
                                  color: themeIsDark == true
                                      ? AppColors.darkText
                                      : AppColors.lightText,
                                  fontFamily: 'Montserrat',
                                  fontSize: fontSize ?? 18,
                                  fontStyle: FontStyle.normal,
                                ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            subtitle ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.cardExtraDescriptionStyle
                                .copyWith(color: AppColors.primaryBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

// class SummaryCard extends ConsumerWidget {
//   final IconData icon;
//   final String title;
//   final String value;
//   final String subtitle;
//   final VoidCallback onPressedCallBack;

//   const SummaryCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.value,
//     required this.subtitle,
//     required this.onPressedCallBack,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeIsDark = ref.watch(themeIsDarkProvider);
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: GestureDetector(
//         onTap: onPressedCallBack,
//         child: Container(
//           padding: const EdgeInsets.all(18),

//           decoration: BoxDecoration(
//             color: themeIsDark == true
//                 ? AppColors.darkCard
//                 : AppColors.lightCard,
//             borderRadius: BorderRadius.circular(9),
//             border: Border.all(
//               color: themeIsDark == true
//                   ? AppColors.darkBorder
//                   : AppColors.lightBorder,
//             ),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffEDF3FF),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(icon, color: const Color(0xff1769F5)),
//               ),

//               const SizedBox(width: 13),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       title,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Color(0xff718096),
//                       ),
//                     ),

//                     const SizedBox(height: 5),

//                     Text(
//                       value,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 19,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff12234A),
//                       ),
//                     ),

//                     const SizedBox(height: 3),

//                     Text(
//                       subtitle,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 11,
//                         color: Color(0xff718096),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
