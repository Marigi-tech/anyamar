import 'package:anyamar/forms/sign_up_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_shell_web.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormShellWeb(
      photoRight: true,
      webForm: SignUpForm(),
      imageAsset: 'assets/images/mosque.jpg',
    );
  }
}
