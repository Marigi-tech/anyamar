import 'package:anyamar/commons/exports.dart';

class WhatsAppBackgroundImageWidget extends ConsumerWidget {
  const WhatsAppBackgroundImageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeIsDarkProvider);
    return Image.asset(
      'assets/images/whatsappbg.jpg',
      scale: 2.0,
      color: themeMode
          ? AppColorsConstant.darkNavColor
          : AppColorsConstant.lightNavColor,
    );
  }
}
