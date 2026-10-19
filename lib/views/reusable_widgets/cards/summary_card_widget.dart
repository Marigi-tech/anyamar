import 'package:anyamar/commons/exports.dart';

class SummaryCard extends ConsumerWidget {
  final IconData? icon;
  final String? title;
  final dynamic value;
  final String? subtitle;
  final Color? iconCardColor;
  final double? fontSize;
  final VoidCallback? onPressedCallBack;
  final Widget? isChartWidget;
  final bool? isWidget;

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
    this.isWidget,
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
            top: 15,
            right: 10,
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
                    width: 25,
                    height: 25,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: iconCardColor != null
                            ? iconCardColor!.withValues(alpha: 0.2)
                            : AppColors.primaryBlue.withValues(alpha: 0.2),
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
                                  fontSize: 12,
                                  color: Color(0xff718096),
                                  fontStyle: FontStyle.normal,
                                ),
                          ),

                          const SizedBox(height: 4),

                          isWidget == true
                              ? value
                              : Text(
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
