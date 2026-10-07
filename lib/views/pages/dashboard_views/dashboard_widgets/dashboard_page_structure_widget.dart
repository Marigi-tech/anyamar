import 'package:anyamar/commons/exports.dart';

class DashboardPageStructure extends ConsumerWidget {
  final String? introText;
  final List<Widget> introRowWidgets;
  final String? pageTitle;
  final String? supplementaryText;
  final Widget scrollableDashboardWidget;
  final bool? isTable;
  final Widget? introButton;
  final Widget? pageTitleWidget;

  const DashboardPageStructure({
    super.key,
    required this.introText,
    required this.introRowWidgets,
    this.pageTitle,
    this.supplementaryText,
    required this.scrollableDashboardWidget,
    this.isTable,
    this.introButton,
    this.pageTitleWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------------------
          // INTRO
          // ------------------------------------------------
          IntroTextWidget(dashboardItem: introText ?? ''),

          SizedBox(height: introButton != null ? 15 : 20),

          // ------------------------------------------------
          // PAGE CONTENT
          // ------------------------------------------------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------------------------------------
                // PAGE HEADER
                // ------------------------------------------------
                _PageHeader(
                  pageTitle: pageTitle,
                  pageTitleWidget: pageTitleWidget,
                  supplementaryText: supplementaryText,
                  introRowWidgets: introRowWidgets,
                  themeIsDark: themeIsDark,
                  introButton: introButton,
                ),

                const SizedBox(height: 10),

                // ------------------------------------------------
                // TABLE / CONTENT
                // ------------------------------------------------
                isTable == true
                    ? Expanded(child: scrollableDashboardWidget)
                    : Expanded(
                        child: SingleChildScrollView(
                          child: scrollableDashboardWidget,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntroButtonWidget extends StatefulWidget {
  final String? buttonText;
  final GestureTapCallback? onPressedCallBack;
  const IntroButtonWidget({super.key, this.buttonText, this.onPressedCallBack});

  @override
  State<IntroButtonWidget> createState() => _IntroButtonWidgetState();
}

class _IntroButtonWidgetState extends State<IntroButtonWidget> {
  Color textColor = AppColors.primaryBlue;
  bool isUnderLined = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          textColor = AppColors.darkBlueColor;
          isUnderLined = true;
        });
      },
      onExit: (event) {
        setState(() {
          textColor = AppColors.primaryBlue;
          isUnderLined = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onPressedCallBack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back, color: textColor, size: 13),
            SizedBox(width: 10.0),
            Text(
              widget.buttonText ?? '',

              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                color: textColor,
                fontStyle: FontStyle.normal,
                decoration: isUnderLined ? TextDecoration.underline : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  final String? pageTitle;
  final String? supplementaryText;
  final List<Widget> introRowWidgets;
  final bool themeIsDark;
  final Widget? introButton;
  final Widget? pageTitleWidget;

  const _PageHeader({
    required this.pageTitle,
    required this.supplementaryText,
    required this.introRowWidgets,
    required this.themeIsDark,
    this.introButton,
    this.pageTitleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------------------------
        // TITLE
        // ------------------------------------------
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              introButton ?? SizedBox.shrink(),
              SizedBox(height: 6),

              pageTitleWidget ??
                  Text(
                    pageTitle ?? '',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: themeIsDark
                          ? AppColors.darkText
                          : const Color(0xff12234A),
                    ),
                  ),

              const SizedBox(height: 5),

              Text(
                supplementaryText ?? '',
                style: const TextStyle(fontSize: 14, color: Color(0xff718096)),
              ),
            ],
          ),
        ),

        // ------------------------------------------
        // ACTION BUTTONS
        // ------------------------------------------
        if (introRowWidgets.isNotEmpty)
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: introRowWidgets,
            ),
          ),
      ],
    );
  }
}
