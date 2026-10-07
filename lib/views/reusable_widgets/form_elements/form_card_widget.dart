import 'package:anyamar/commons/exports.dart';

class FormCardWidget extends ConsumerWidget {
  final double? noOfColumnsPerRow;
  final IconData? formTitleIcon;
  final String? formCardTitle;
  final List<Widget> formInputs;
  const FormCardWidget({
    super.key,
    required this.noOfColumnsPerRow,
    this.formCardTitle,
    required this.formInputs,
    this.formTitleIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.read(themeIsDarkProvider);
    double spacing = 14;
    double runSpacing = 18;
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: themeIsDark == true
              ? AppColors.darkBorder
              : const Color(0xffE5EAF1),
        ),
      ),

      color: themeIsDark == true
          ? AppColors.darkElevatedCard
          : AppColors.whiteColor,

      child: Padding(
        padding: EdgeInsets.only(
          left: 30.0,
          right: 30.0,
          top: 20.0,
          bottom: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (formCardTitle != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (formTitleIcon != null)
                    Icon(formTitleIcon, size: 18, color: AppColors.primaryBlue),
                  if (formTitleIcon != null) SizedBox(width: 10),
                  Text(
                    formCardTitle!,
                    style: CustomTextStyles.cardDescriptionStyle.copyWith(
                      color: AppColors.buttonBlueColor,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            if (formCardTitle != null) SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                final columns = width >= 1100
                    ? noOfColumnsPerRow ?? 2
                    : width >= 700
                    ? noOfColumnsPerRow ?? 2
                    : 1;

                final itemWidth = (width - ((columns - 1) * spacing)) / columns;

                return Wrap(
                  spacing: spacing,
                  runSpacing: runSpacing,
                  children: [
                    for (final child in formInputs)
                      SizedBox(width: itemWidth, child: child),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
