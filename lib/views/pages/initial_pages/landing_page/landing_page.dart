import 'package:flutter/material.dart';
import 'package:test_app/constants/constants.dart';
import 'package:test_app/views/pages/initial_pages/login_page/login_page.dart';
import 'package:test_app/views/pages/initial_pages/signup_page/sign_up_page.dart';
import 'package:test_app/views/reusable_widgets/buttons/button_widget.dart';
import 'package:test_app/views/reusable_widgets/buttons/text_button_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          //Background image
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.35), // overlay
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //? ----- Logo -----
            Image.asset('assets/images/logo.png', height: size.height * .55),
            //?----- Intro text -----
            Padding(
              padding: EdgeInsets.only(right: 45.0, left: 15.0),
              child: RichText(
                text: TextSpan(
                  text: "S",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    color: AppColorsConstant.yellowColor,
                    fontFamily: 'Lato',
                  ),
                  children: [
                    TextSpan(
                      text: "mart property solutions for ",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: AppColorsConstant.whiteColor,
                        fontFamily: 'Lato',
                      ),
                    ),
                    TextSpan(
                      text: "elevated living.",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: AppColorsConstant.greenColor,
                        fontFamily: 'Lato',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Buttons
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 30.0),

              child: Column(
                children: [
                  //? ----- Get Started Button -----
                  ColorButtonWidget(
                    onPressedCallBack: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpPage()),
                      );
                    },
                    buttonTitle: 'Get Started',
                    buttonColor: AppColorsConstant.greenColor,
                  ),
                  //Spacing
                  SizedBox(height: 10),
                  //? ----- Sign In Button -----
                  AppTextButton(
                    onPressedCallBack: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    buttonTitle: "Sign in",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
