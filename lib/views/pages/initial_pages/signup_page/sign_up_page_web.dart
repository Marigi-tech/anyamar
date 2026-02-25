import 'package:flutter/material.dart';
import 'package:test_app/views/pages/initial_pages/form_shell_web.dart';
import 'package:test_app/views/pages/initial_pages/signup_page/sign_up_form.dart';

class SignUpPageWeb extends StatelessWidget {
  const SignUpPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return FormShellWeb(webForm: SignUpForm());
    // return Row(
    //   children: [
    //     Expanded(
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
    //         child: SignUpForm(),
    //       ),
    //     ),
    //   ],
    // );
  }
}
