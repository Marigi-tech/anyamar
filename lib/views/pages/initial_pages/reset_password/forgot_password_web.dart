import 'package:flutter/material.dart';
import 'package:test_app/views/pages/initial_pages/form_shell_web.dart';
import 'package:test_app/views/pages/initial_pages/reset_password/forgot_password_form.dart';

class ForgotPasswordWeb extends StatelessWidget {
  const ForgotPasswordWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return FormShellWeb(webForm: ForgotPasswordForm());
  }
}
