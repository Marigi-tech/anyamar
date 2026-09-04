import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/commons/constants.dart';
import 'package:anyamar/data/providers/theme_provider.dart';

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
