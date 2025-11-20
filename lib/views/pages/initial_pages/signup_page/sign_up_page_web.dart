import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/pages/initial_pages/form_image.dart';
import 'package:test_app/views/pages/initial_pages/login_page/login_page.dart';
import 'package:test_app/views/pages/initial_pages/signup_page/sign_up_form.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';

class SignUpPageWeb extends StatelessWidget {
  const SignUpPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FormImage(
          imagePath: 'assets/images/login.png',
          introText: 'Anyamar property management solutions',
          helperText:
              'Where the power of management is done in the click of a button',
          button: ColorButtonWidget(
            onPressedCallBack: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => LoginPage()));
            },
            buttonTitle: 'Sign in',
            buttonColor: AppColorsConstant.yellowColor,
          ),
          buttonText: 'Already have an account?',
        ),
        Expanded(child: SignUpForm()),
      ],
    );
  }
}
