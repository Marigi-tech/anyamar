import 'package:anyamar/forms/sign_up_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_shell_web.dart';
import 'package:flutter/material.dart';

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
    return FormShellWeb(
      photoRight: true,
      webForm: SignUpForm(),
      imageAsset: 'assets/images/mosque.jpg',
    );
  }
}
