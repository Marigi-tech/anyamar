import 'package:flutter/material.dart';
import 'package:anyamar/forms/forgot_password_form.dart';

class ForgotPasswordMobile extends StatelessWidget {
  const ForgotPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ForgotPasswordForm(),
    );
  }
}
