import 'package:flutter/material.dart';
import 'package:test_app/responsiveness/responsiveness.dart';
import 'package:test_app/views/pages/initial_pages/signup_page/sign_up_page_mobile.dart';
import 'package:test_app/views/pages/initial_pages/signup_page/sign_up_page_web.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Responsiveness.isDesktop(context)
          ? SignUpPageWeb()
          : SignUpPageMobile(),
    );
  }
}
