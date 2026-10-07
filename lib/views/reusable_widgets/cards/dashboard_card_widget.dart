import 'package:anyamar/commons/exports.dart';

class DashboardCardWidget extends ConsumerStatefulWidget {
  final String cardTitle;
  final Widget child;
  final Widget? buttonWidget1;
  final Widget? buttonWidget2;
  final double? cardHeight;
  const DashboardCardWidget({
    super.key,
    required this.cardTitle,
    required this.child,
    this.buttonWidget1,
    this.buttonWidget2,
    this.cardHeight,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardCardWidgetState();
}

class _DashboardCardWidgetState extends ConsumerState<DashboardCardWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);

    return MouseRegion(
      onHover: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: SizedBox(
        height: widget.cardHeight ?? 350,
        child: Card(
          elevation: isHovered ? 6.0 : 4.0,
          color: themeIsDark == true
              ? AppColors.darkElevatedCard.withValues(alpha: 0.9)
              : AppColors.whiteColor.withValues(alpha: 0.9),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //CARD TITILE AND ACTION BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.cardTitle,
                      style: AppTextStylesConstant.cardDescriptionStyle
                          .copyWith(
                            color: themeIsDark == true
                                ? AppColors.whiteColor
                                : AppColors.blueGreyColor,
                            fontStyle: FontStyle.normal,
                            fontSize: 13,
                          ),
                    ),

                    //Button Widgets go here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.buttonWidget1 ?? SizedBox.shrink(),
                        SizedBox(width: 5),
                        widget.buttonWidget2 ?? SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
                CustomDividerWidget(),
                SizedBox(height: 20.0),
                Expanded(child: SingleChildScrollView(child: widget.child)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
