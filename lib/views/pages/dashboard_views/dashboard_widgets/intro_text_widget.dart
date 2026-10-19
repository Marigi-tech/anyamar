import 'package:anyamar/commons/exports.dart';

class IntroTextWidget extends ConsumerWidget {
  final String dashboardItem;
  const IntroTextWidget({super.key, required this.dashboardItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Anyamar / $dashboardItem',
        style: CustomTextStyles.cardDescriptionStyle.copyWith(
          color: AppColors.primaryBlue,
          letterSpacing: -0.2,
          fontSize: 16,
        ),
      ),
    );
  }
}
