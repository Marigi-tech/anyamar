import 'package:flutter/material.dart';
import 'package:anyamar/forms/sign_up_form.dart';

class SignUpPageMobile extends StatelessWidget {
  const SignUpPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: SignUpForm(),
    );
  }
}
