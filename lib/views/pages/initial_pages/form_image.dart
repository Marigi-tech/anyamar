import 'package:flutter/material.dart';
import 'package:test_app/constants/constants.dart';
import 'package:test_app/responsiveness/screen_size.dart';
import 'package:test_app/views/reusable_widgets/buttons/button_widget.dart';

class FormImage extends StatelessWidget {
  final String imagePath;
  final String introText;
  final String helperText;
  final ColorButtonWidget button;
  final String buttonText;
  const FormImage({
    super.key,
    required this.imagePath,
    required this.introText,
    required this.helperText,
    required this.button,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Image
            Center(
              child: Image.asset(
                imagePath,

                fit: BoxFit.scaleDown,
                width: getSizeFromContext(context).width * .30,
              ),
            ),
            //Intro Text
            Text(
              introText,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 35, letterSpacing: 1.15),
            ),
            SizedBox(height: 10),

            //Helper Text
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                helperText,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColorsConstant.darkBlueColor,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 10),

            //Button
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(width: 10),
                  button,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
