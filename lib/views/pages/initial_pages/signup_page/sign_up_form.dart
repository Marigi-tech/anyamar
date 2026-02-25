import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/pages/initial_pages/form_pages.dart';
import 'package:test_app/views/pages/initial_pages/login_page/login_page.dart';
import 'package:test_app/views/pages/widget_tree/widget_tree.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';
import 'package:test_app/views/widgets/form_elements/text_input_widget.dart';
import 'package:test_app/views/widgets/social_icons_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
      pageTitle: 'Create account',
      isSignInOrSignUp: true,

      form: Form(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              //? ----- Name-----
              TextInputWidget(
                fieldController: nameController,
                hintText: 'Enter your name',
              ),

              SizedBox(height: 15.0),

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
              //?-- Confirm password
              TextInputWidget(
                fieldController: confirmPasswordController,
                hintText: 'Confirm password',
              ),
              SizedBox(height: 15.0),
              //? Sign in option
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
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Already have an account? sign In',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 0.6,
                        color: textColor,
                        fontWeight: FontWeight.w100,
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
                buttonTitle: 'Create account',
                buttonColor: AppColorsConstant.greenColor,
              ),

              SizedBox(height: 30),
              //Add social sign up icons here
              SocialIconsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
