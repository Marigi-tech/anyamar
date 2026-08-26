import 'package:flutter/material.dart';
import 'package:anyamar/responsiveness/responsiveness.dart';
import 'package:anyamar/views/pages/initial_pages/signin_page/login_page_mobile.dart';
import 'package:anyamar/views/pages/initial_pages/signin_page/login_page_web.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Responsiveness.isMobile(context)
          ? LoginPageMobile()
          : LogInPageWeb(),
    );
  }
}
