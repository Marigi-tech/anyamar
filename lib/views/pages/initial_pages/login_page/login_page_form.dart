import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/pages/initial_pages/reset_password/forgot_password_page.dart';
import 'package:test_app/views/pages/initial_pages/form_pages.dart';
import 'package:test_app/views/pages/widget_tree/widget_tree.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';
import 'package:test_app/views/widgets/form_elements/text_input_widget.dart';
import 'package:test_app/views/widgets/social_icons_widget.dart';

class LogInPageForm extends StatefulWidget {
  const LogInPageForm({super.key});

  @override
  State<LogInPageForm> createState() => _LogInPageFormState();
}

class _LogInPageFormState extends State<LogInPageForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Color? textColor;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormPages(
      pageTitle: 'Sign In',
      isSignInOrSignUp: true,
      form: Form(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),

              //? ----- Email Adress -----
              TextInputWidget(
                fieldController: emailController,
                hintText: 'Enter Email adress',
              ),

              SizedBox(height: 15.0),

              //? ----- Password -----
              TextInputWidget(
                fieldController: passwordController,
                hintText: 'Enter password',
                isPassword: true,
              ),
              SizedBox(height: 15.0),
              //? forgot password
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
                      'Forgot password?',
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
              SizedBox(height: 50.0),
              //? ------ Log in button ------
              ColorButtonWidget(
                onPressedCallBack: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => WidgetTree()),
                  );
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
