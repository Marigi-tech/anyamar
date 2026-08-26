import 'dart:developer';

import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/views/pages/initial_pages/reset_password/forgot_password_page.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/pages/widget_tree/widget_tree.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:anyamar/views/reusable_widgets/social_icons_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogInPageForm extends ConsumerStatefulWidget {
  const LogInPageForm({super.key});

  @override
  ConsumerState<LogInPageForm> createState() => _LogInPageFormState();
}

class _LogInPageFormState extends ConsumerState<LogInPageForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  Color? textColor;
  final _formKey = GlobalKey<FormState>();
  bool isSuccess = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  //Sign in user
  Future<void> _signInUser() async {
    try {
      await ref
          .read(authServiceProvider)
          .signInUser(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      final currentUser = ref.read(authServiceProvider).currentUser;
      // final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        setState(() {
          isSuccess = true;
          errorMessage = 'user credential isn\'t the issue';
        });
        _redirectToDashboard();
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.code;
        isSuccess = false;
      });
    }
  }

  //Redirection to user dashboard
  Future<void> _redirectToDashboard() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => WidgetTree()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormPages(
      pageTitle: 'Sign In',
      isSignInOrSignUp: true,
      form: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),

              //Email Adress
              FormLabel(label: 'Email address', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter email address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter email address';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15.0),

              //Password
              FormLabel(label: 'Password', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter password',
                  isPassword: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              //Forgot password
              Align(
                alignment: Alignment.topRight,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onHover: (event) {
                    setState(() {
                      textColor = AppColorsConstant.greenColor;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      textColor = null;
                    });
                  },

                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      'Forgot password ?',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 1,
                        color: textColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                errorMessage ?? 'no error',
                style: TextStyle(
                  color: isSuccess
                      ? AppColorsConstant.greenColor
                      : AppColorsConstant.redColor,
                ),
              ),
              SizedBox(height: 50.0),
              //? ------ Log in button ------
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (_formKey.currentState!.validate()) {
                    await _signInUser();
                    log('form validation is succesfull');
                  } else {
                    log('form validation fails');
                  }
                },
                buttonTitle: 'Sign In',
                buttonColor: AppColorsConstant.greenColor,
              ),

              SizedBox(height: 30),
              SocialIconsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
