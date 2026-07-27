import 'package:anyamar/constants/commons.dart';

class CentralButton extends StatefulWidget {
  final int index;
  final BoxDecoration backgroundColor;
  const CentralButton({
    super.key,
    required this.index,
    required this.backgroundColor,
  });

  @override
  State<CentralButton> createState() => _CentralButtonState();
}

class _CentralButtonState extends State<CentralButton> {
  late BoxDecoration backgroundColor;
  @override
  void initState() {
    backgroundColor = widget.backgroundColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          backgroundColor = AppGradient.gradientLightGreen;
        });
      },
      onExit: (event) {
        setState(() {
          backgroundColor = AppGradient.gradientGreen;
        });
      },
      child: GestureDetector(
        onTap: () {
          selectedPageNotifier.value = widget.index;
        },

        child: Container(
          height: 65,
          width: 65,

          decoration: BoxDecoration(
            gradient: backgroundColor.gradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColorsConstant.lightGreenColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.home,
            color: AppColorsConstant.whiteColor,
            size: 22,
          ),
        ),
      ),
    );
  }
}
