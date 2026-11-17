import 'package:anyamar/forms/forgot_password_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_shell_web.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormShellWeb(webForm: ForgotPasswordForm(), photoRight: false);
  }
}
