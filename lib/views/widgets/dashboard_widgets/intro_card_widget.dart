import 'package:flutter/cupertino.dart';
import 'package:test_app/data/constants/commons.dart';

class IntroCardWidget extends StatefulWidget {
  final IconData cardIcon;
  final String cardTitle;
  final String description;
  final String? extraInfo;

  const IntroCardWidget({
    super.key,
    required this.cardIcon,
    required this.cardTitle,
    required this.description,
    this.extraInfo,
  });

  @override
  State<IntroCardWidget> createState() => _IntroCardWidgetState();
}

class _IntroCardWidgetState extends State<IntroCardWidget> {
  late bool isHovered;
  @override
  void initState() {
    super.initState();
    isHovered = false;
  }

  @override
  Widget build(BuildContext context) {
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
        width: 270,
        child: GestureDetector(
          child: Card(
            elevation: isHovered ? 10.0 : 6.0,
            shadowColor: isHovered ? AppColorsConstant.blueGreyColor : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
                left: 10.0,
                right: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Icon
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 6.0,

                          shadowColor: isHovered
                              ? AppColorsConstant.blueGreyColor
                              : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 10.0,
                            ),
                            child: Icon(
                              widget.cardIcon,
                              color: isHovered
                                  ? AppColorsConstant.lightGreenColor
                                  : null,
                              size: 16,
                              weight: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 06.0),
                        //Title
                        Text(
                          widget.cardTitle,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 0.7,
                            fontFamily: 'Lato',
                            fontStyle: FontStyle.italic,
                            color: isHovered
                                ? AppColorsConstant.lightGreenColor
                                : AppColorsConstant.darkBlueColor,
                          ),
                        ),
                        // SizedBox(width: 40.0),
                        // //Wave
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: Icon(
                        //     CupertinoIcons.waveform,
                        //     color: isHovered
                        //         ? AppColorsConstant.lightGreenColor
                        //         : null,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.extraInfo ?? '',
                        style: TextStyle(
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSize: 12,
                          color: AppColorsConstant.darkBlueColor,
                          fontFamily: 'lato',
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
