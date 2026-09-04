import 'package:anyamar/commons/exports.dart';

class IntroCardWidget extends StatefulWidget {
  final IconData cardIcon;
  final String cardTitle;
  final String description;
  final String? extraInfo;
  final VoidCallback onPressedCallBack;

  const IntroCardWidget({
    super.key,
    required this.cardIcon,
    required this.cardTitle,
    required this.description,
    this.extraInfo,
    required this.onPressedCallBack,
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
        width: 240,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: widget.onPressedCallBack,
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

                          shadowColor: isHovered
                              ? AppColorsConstant.blueGreyColor
                              : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 15.0,
                            ),
                            child: Icon(
                              widget.cardIcon,
                              color: isHovered
                                  ? AppColorsConstant.lightGreenColor
                                  : null,
                              size: 18,
                              weight: 20.0,
                            ),
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          crossAxisAlignment: WrapCrossAlignment.end,
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
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 02),
                    //Title
                    Padding(
                      padding: EdgeInsetsGeometry.only(left: 10, top: 05),
                      child: Text(
                        widget.cardTitle.toUpperCase(),
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          color: isHovered
                              ? AppColorsConstant.kOrange1
                              : AppColorsConstant.greenColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
