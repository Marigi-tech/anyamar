import 'package:anyamar/data/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/commons/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormLabel extends ConsumerWidget {
  final String label;
  final bool? isRequired;
  const FormLabel({super.key, required this.label, this.isRequired = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          text: label,
          children: [
            if (isRequired == true)
              TextSpan(
                text: ' * ',
                style: TextStyle(
                  color: AppColorsConstant.kRed3,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                ),
              ),
          ],
          style: CustomTextStyles.cardDescriptionStyle.copyWith(
            fontStyle: FontStyle.normal,
            fontSize: 15,
            color: themeIsDark == true ? AppColorsConstant.whiteColor : null,
          ),
        ),
      ),
    );
  }
}
