import 'package:anyamar/commons/exports.dart';

class QuickActionsWidget extends StatelessWidget {
  final List<Widget> children;
  const QuickActionsWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return DashboardCardWidget(
      cardTitle: 'Quick actions',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...children],
      ),
    );
  }
}

class QWidget extends ConsumerStatefulWidget {
  final Widget child;
  final GestureTapCallback? onPressedCallBack;
  const QWidget({super.key, required this.child, this.onPressedCallBack});

  @override
  ConsumerState<QWidget> createState() => _QWidgetState();
}

class _QWidgetState extends ConsumerState<QWidget> {
  Color? currentBg;
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);

    Color? hoverBackground = themeIsDark == true
        ? AppColors.darkBlue.withValues(alpha: 0.9)
        : AppColorsConstant.kPrimaryColor.withValues(alpha: 0.9);
    Color? background = themeIsDark == true
        ? AppColors.darkCard.withValues(alpha: 0.9)
        : AppColors.lightCard.withValues(alpha: 0.9);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          currentBg = hoverBackground;
        });
      },
      onExit: (event) {
        setState(() {
          currentBg = background;
        });
      },
      child: GestureDetector(
        onTap: widget.onPressedCallBack,
        child: Container(
          decoration: BoxDecoration(color: currentBg),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
          child: widget.child,
        ),
      ),
    );
  }
}
