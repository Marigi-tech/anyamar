import 'package:flutter/material.dart';
import 'package:test_app/responsiveness/responsiveness.dart';
import 'package:test_app/views/pages/initial_pages/reset_password/forgot_password_mobile.dart';
import 'package:test_app/views/pages/initial_pages/reset_password/forgot_password_web.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Responsiveness.isMobile(context)
          ? ForgotPasswordMobile()
          : ForgotPasswordWeb(),
    );
  }
}
