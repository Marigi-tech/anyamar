import 'package:flutter/material.dart';
import 'package:test_app/constants/constants.dart';

class FormLabel extends StatelessWidget {
  final String label;
  final bool? isRequired;
  const FormLabel({super.key, required this.label, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
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
          ),
        ),
      ),
    );
  }
}
