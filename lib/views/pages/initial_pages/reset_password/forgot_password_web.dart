import 'package:flutter/material.dart';
import 'package:test_app/responsiveness/screen_size.dart';
import 'package:test_app/views/pages/initial_pages/reset_password/forgot_password_form.dart';

class ForgotPasswordWeb extends StatelessWidget {
  const ForgotPasswordWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/login.png',
                  fit: BoxFit.scaleDown,
                  width: getSizeFromContext(context).width * .40,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: ForgotPasswordForm()),
      ],
    );
  }
}
