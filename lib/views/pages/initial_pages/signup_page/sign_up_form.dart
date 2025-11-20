import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/pages/initial_pages/form_pages.dart';
import 'package:test_app/views/widget_tree.dart';
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
