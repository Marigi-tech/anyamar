import 'package:anyamar/commons/exports.dart';

class SummaryCard extends ConsumerStatefulWidget {
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
  ConsumerState<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends ConsumerState<SummaryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final accentColor = widget.iconCardColor ?? AppColors.primaryBlue;
    bool isMobile = Responsiveness.isMobile(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (event) => setState(() {
        isHovered = true;
      }),

      onExit: (event) => setState(() {
        isHovered = false;
      }),

      child: GestureDetector(
        onTap: widget.onPressedCallBack,

        child: AnimatedPadding(
          padding: isHovered
              ? const EdgeInsets.only(bottom: 3.0)
              : const EdgeInsets.only(top: 3.0),

          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,

          child: AnimatedScale(
            scale: isHovered ? 1.0001 : 1.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,

            // ==========================================
            // FIXED CARD DIMENSIONS
            // ==========================================
            child: SizedBox(
              // width: 240,
              // height: 300,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ======================================
                  // MAIN CARD
                  // ======================================
                  Card(
                    elevation: isHovered ? 14.0 : 4.0,
                    shadowColor: isHovered
                        ? widget.iconCardColor?.withValues(alpha: 0.5) ??
                              AppColors.primaryBlue.withValues(alpha: 0.5)
                        : themeIsDark != false
                        ? AppColors.darkElevatedCard.withValues(alpha: 0.9)
                        : AppColors.whiteColor.withValues(alpha: 0.9),

                    color: themeIsDark != false
                        ? AppColors.darkCard.withValues(alpha: 0.9)
                        : AppColors.lightCard.withValues(alpha: 0.9),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 20.0,
                        right: 20.0,
                      ),

                      // ==================================
                      // SCROLLABLE CONTENT
                      // ==================================
                      child: SingleChildScrollView(
                        child:
                            widget.isChartWidget ??
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,

                              crossAxisAlignment: CrossAxisAlignment.start,

                              mainAxisSize: MainAxisSize.min,

                              children: [
                                // ==============================
                                // CARD TITLE
                                // ==============================
                                Text(
                                  widget.title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                  style: CustomTextStyles.cardDescriptionStyle
                                      .copyWith(
                                        fontSize: 14,
                                        color: themeIsDark
                                            ? AppColors.darkText
                                            : AppColors.lightText,
                                        fontStyle: FontStyle.normal,
                                      ),
                                ),

                                const SizedBox(height: 5.0),

                                // ==============================
                                // ICON & INFORMATION
                                // ==============================
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  mainAxisSize: MainAxisSize.max,

                                  children: [
                                    // ==========================
                                    // VALUE & SUBTITLE
                                    // ==========================
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        mainAxisSize: MainAxisSize.min,

                                        children: [
                                          const SizedBox(height: 6),

                                          // VALUE
                                          widget.isWidget == true
                                              ? widget.value ?? const SizedBox()
                                              : Text(
                                                  widget.value?.toString() ??
                                                      '',
                                                  softWrap: true,

                                                  style: CustomTextStyles
                                                      .cardDescriptionStyle
                                                      .copyWith(
                                                        color: themeIsDark
                                                            ? AppColors.darkText
                                                            : AppColors
                                                                  .lightText,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: isMobile
                                                            ? 13
                                                            : 22,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                ),
                                          //Space
                                          SizedBox(height: 10.0),

                                          // SUBTITLE
                                          Text(
                                            widget.subtitle ?? '',
                                            softWrap: true,

                                            style: CustomTextStyles
                                                .cardDescriptionStyle
                                                .copyWith(
                                                  color:
                                                      LandingHeroColors.muted,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 15),

                                    // ==========================
                                    // ICON
                                    // ==========================
                                    SizedBox(
                                      width: 40,
                                      height: 40,

                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: accentColor.withValues(
                                            alpha: 0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),

                                        child: Icon(
                                          widget.icon,
                                          size: 17,
                                          color: accentColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      ),
                    ),
                  ),

                  // ======================================
                  // LEFT VERTICAL COLOURED STREAK
                  // ======================================
                  Positioned(
                    top: 4,
                    bottom: 4,
                    left: 0,

                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
