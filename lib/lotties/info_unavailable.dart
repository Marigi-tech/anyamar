import 'package:anyamar/commons/exports.dart';
import 'package:lottie/lottie.dart';

class InfoUnavailableLottie extends ConsumerWidget {
  final Widget ctaButtonWidget;
  final String text;
  const InfoUnavailableLottie({
    required this.ctaButtonWidget,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 15),
            Lottie.asset('assets/lotties/login.json', height: 300),

            SizedBox(height: 15),
            ctaButtonWidget,
          ],
        ),
      ),
    );
  }
}
