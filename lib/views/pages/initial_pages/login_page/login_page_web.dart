import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/pages/initial_pages/form_image.dart';
import 'package:test_app/views/pages/initial_pages/login_page/login_page_form.dart';
import 'package:test_app/views/pages/initial_pages/signup_page/sign_up_page.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';

class LogInPageWeb extends StatefulWidget {
  const LogInPageWeb({super.key});

  @override
  State<LogInPageWeb> createState() => _LogInPageWebState();
}

class _LogInPageWebState extends State<LogInPageWeb> {
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
              ).push(MaterialPageRoute(builder: (_) => SignUpPage()));
            },
            buttonTitle: 'Sign up',
            buttonColor: AppColorsConstant.yellowColor,
          ),
          buttonText: 'Dont have an account?',
        ),
        Expanded(child: LogInPageForm()),
      ],
    );
  }
}
