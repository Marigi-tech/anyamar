import 'package:anyamar/commons/exports.dart';

class UlitiesChargeWidget extends ConsumerStatefulWidget {
  final Rent? rentObject;
  const UlitiesChargeWidget({super.key, this.rentObject});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UlitiesChargeWidgetState();
}

class _UlitiesChargeWidgetState extends ConsumerState<UlitiesChargeWidget> {
  @override
  Widget build(BuildContext context) {
    return DashboardCardWidget(
      cardTitle: 'Utilitites\'s charges',
      cardHeight: 220,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (widget.rentObject?.utilities != null)
                ...widget.rentObject!.utilities!.asMap().entries.map((entry) {
                  final index = entry.key;
                  final utility = entry.value;
                  return SizedBox(
                    width: 200,
                    child: UtilityCard(
                      icon: getUtilityIcon(utility.utilityName),
                      iconBackgroundColor:
                          avatarBackgroundColors[index %
                              avatarBackgroundColors.length],
                      title: utility.utilityName.label,
                      charge: 'Ksh ${utility.amountPayable}',
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}

class UtilityCard extends ConsumerWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String charge;

  const UtilityCard({
    super.key,
    required this.iconBackgroundColor,
    required this.icon,
    required this.title,
    required this.charge,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClearButtonWidget(
      title: title,
      iconData: icon,
      description: charge,
      iconBackgroundColor: iconBackgroundColor,
    );
  }
}

class ClearButtonWidget extends ConsumerStatefulWidget {
  final String title;
  final String? description;
  final String? extraDescription;
  final IconData? iconData;
  final VoidCallbackAction? onPressedCallBack;
  final double? fontSize;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  const ClearButtonWidget({
    super.key,
    required this.title,
    this.description,
    this.extraDescription,
    this.iconData,
    this.onPressedCallBack,
    this.fontSize = 13,
    this.iconColor,
    this.iconBackgroundColor,
  });

  @override
  ConsumerState<ClearButtonWidget> createState() => _ClearButtonWidgetState();
}

class _ClearButtonWidgetState extends ConsumerState<ClearButtonWidget> {
  bool isCardHovered = false;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) => setState(() => isCardHovered = true),
      onExit: (event) => setState(() => isCardHovered = false),
      child: GestureDetector(
        onTap: () => widget.onPressedCallBack,
        child: Card(
          color: themeIsDark == true
              ? AppColors.darkElevatedCard.withValues(alpha: 0.9)
              : AppColors.lightCard.withValues(alpha: 0.9),
          margin: EdgeInsets.only(right: 20.0),
          elevation: isCardHovered ? 2.0 : 1.0,
          shadowColor: isCardHovered
              ? AppColors.primaryBlue.withValues(alpha: 0.5)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            child: Padding(
              padding: EdgeInsets.only(
                right: 30.0,
                left: 10.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //Icon
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 4.0,
                    color: widget.iconBackgroundColor,
                    // color: widget.

                    // shadowColor: isHovered
                    //     ? AppColorsConstant.blueGreyColor
                    //     : null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: Icon(
                        widget.iconData,
                        color: AppColors.whiteColor,
                        size: 18,
                        weight: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStylesConstant.cardDescriptionStyle
                            .copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,

                              color: themeIsDark == true
                                  ? AppColors.whiteColor
                                  : Color(0xff718096),
                            ),
                      ),

                      const SizedBox(height: 5),
                      if (widget.description != null)
                        Text(
                          widget.description!,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStylesConstant.cardDescriptionStyle
                              .copyWith(
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                fontStyle: FontStyle.normal,
                                // fontSize: 19,
                                // fontWeight: FontWeight.w700,
                                color: themeIsDark == true
                                    ? AppColors.whiteColor
                                    : Color(0xff12234A),
                              ),
                        ),

                      const SizedBox(height: 3),
                      if (widget.extraDescription != null)
                        Text(
                          widget.extraDescription ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStylesConstant.cardDescriptionStyle
                              .copyWith(
                                letterSpacing: 0.4,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                color: themeIsDark == true
                                    ? AppColors.whiteColor
                                    : Color(0xff718096),
                              ),
                        ),
                    ],
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
