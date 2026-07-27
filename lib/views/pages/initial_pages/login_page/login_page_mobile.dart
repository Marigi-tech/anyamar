import 'package:flutter/material.dart';
import 'package:anyamar/views/pages/initial_pages/login_page/login_page_form.dart';

class LoginPageMobile extends StatefulWidget {
  const LoginPageMobile({super.key});

  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: LogInPageForm(),
    );
  }
}
