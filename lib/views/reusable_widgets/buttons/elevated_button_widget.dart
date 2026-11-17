import 'package:anyamar/commons/exports.dart';

class ElevatedButtonWidget extends ConsumerStatefulWidget {
  final String buttonTitle;
  final VoidCallback onButtonPressedCallBack;
  final Icon? buttonIcon;
  final Color? buttonColor;
  final bool? isClear;
  final bool? isOutlined;
  final double? borderRadius;
  final EdgeInsets? padding;
  final RoundedRectangleBorder? shape;
  const ElevatedButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.onButtonPressedCallBack,
    this.buttonIcon,
    this.buttonColor,
    this.isClear,
    this.isOutlined,
    this.borderRadius,
    this.padding,
    this.shape,
  });
  @override
  ConsumerState<ElevatedButtonWidget> createState() =>
      ElevatedButtonWidgetState();
}

class ElevatedButtonWidgetState extends ConsumerState<ElevatedButtonWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.read(themeIsDarkProvider);
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
      child: ElevatedButton.icon(
        onPressed: widget.onButtonPressedCallBack,
        icon: widget.buttonIcon,
        label: Text(widget.buttonTitle),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isOutlined == true
              ? null
              : widget.isClear == true
              ? themeIsDark == true
                    ? AppColors.darkCard
                    : AppColors.lightCard
              : widget.buttonColor ?? AppColors.buttonBlueColor,
          foregroundColor: widget.isClear == true || widget.isOutlined == true
              ? themeIsDark == true
                    ? AppColors.darkText
                    : AppColors.lightText
              : AppColors.whiteColor,
          side: widget.isOutlined == true
              ? BorderSide(
                  color: widget.buttonColor ?? AppColors.primaryBlue,
                  width: 1.5,
                )
              : null,
          elevation: 0,
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape:
              widget.shape ??
              RoundedRectangleBorder(
                side: BorderSide(
                  style: BorderStyle.solid,
                  color: widget.isOutlined == true
                      ? widget.buttonColor ?? AppColors.buttonBlueColor
                      : AppColorsConstant.transparentColor,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              ),
        ),
      ),
    );
  }
}
