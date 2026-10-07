import 'package:anyamar/commons/exports.dart';

class IntroCardWidget extends ConsumerStatefulWidget {
  final IconData cardIcon;
  final String cardTitle;
  final String description;
  final String? extraInfo;
  final VoidCallback onPressedCallBack;
  final Color? iconColor;
  final Color? iconCardColor;
  final double? descriptionSize;

  const IntroCardWidget({
    super.key,
    required this.cardIcon,
    required this.cardTitle,
    required this.description,
    this.extraInfo,
    required this.onPressedCallBack,
    this.iconColor,
    this.iconCardColor,
    this.descriptionSize,
  });

  @override
  ConsumerState<IntroCardWidget> createState() => _IntroCardWidgetState();
}

class _IntroCardWidgetState extends ConsumerState<IntroCardWidget> {
  late bool isHovered;
  @override
  void initState() {
    super.initState();
    isHovered = false;
  }

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
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
        width: 240,

        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: widget.onPressedCallBack,
            child: Card(
              elevation: isHovered ? 6.0 : 4.0,
              color: themeIsDark == true
                  ? AppColors.darkCard.withValues(alpha: 0.9)
                  : AppColors.lightCard.withValues(alpha: 0.9),
              // shadowColor: isHovered ? AppColorsConstant.blueGreyColor : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  left: 10.0,
                  right: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //Icon
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          elevation: 6.0,
                          color: widget.iconCardColor,

                          // shadowColor: isHovered
                          //     ? AppColorsConstant.blueGreyColor
                          //     : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 15.0,
                            ),
                            child: Icon(
                              widget.cardIcon,
                              color: widget.iconColor,
                              size: 18,
                              weight: 20.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.cardTitle,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,

                                      color: themeIsDark == true
                                          ? AppColors.whiteColor
                                          : Color(0xff718096),
                                    ),
                                // style: const TextStyle(
                                //   fontSize: 15,
                                //   font
                                //   color: Color(0xff718096),
                                // ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                widget.description,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.displayMedium
                                    ?.copyWith(
                                      fontSize: widget.descriptionSize ?? 35,
                                      letterSpacing: 2,
                                      fontFamily: 'Montserrat',
                                      // fontSize: 19,
                                      // fontWeight: FontWeight.w700,
                                      color: themeIsDark == true
                                          ? AppColors.whiteColor
                                          : Color(0xff12234A),
                                    ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                widget.extraInfo ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.displaySmall
                                    ?.copyWith(
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
                        ),
                      ],
                    ),
                    SizedBox(height: 02),
                    //Title
                    // Padding(
                    //   padding: EdgeInsetsGeometry.only(left: 10, top: 05),
                    //   child: Text(
                    //     widget.cardTitle.toUpperCase(),
                    //     style: TextStyle(
                    //       fontSize: 15,
                    //       letterSpacing: 2,
                    //       fontFamily: 'Montserrat',
                    //       fontStyle: FontStyle.normal,
                    //       color: isHovered
                    //           ? AppColorsConstant.kOrange1
                    //           : AppColorsConstant.greenColor,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
