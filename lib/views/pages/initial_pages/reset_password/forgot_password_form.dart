import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/views/pages/initial_pages/form_pages.dart';
import 'package:test_app/views/widgets/buttons/button_widget.dart';
import 'package:test_app/views/widgets/form_elements/text_input_widget.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return FormPages(
      pageTitle: 'Reset password',

      form: Form(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Enter your email so as to receive the reset code'),
              ),
              SizedBox(height: 30.0),

              //? ----- Email Adress -----
              TextInputWidget(
                fieldController: emailController,
                hintText: 'Enter Email address',
              ),
              SizedBox(height: 30.0),
              //? send
              ColorButtonWidget(
                onPressedCallBack: () {},
                buttonTitle: 'Submit',
                buttonColor: AppColorsConstant.greenColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
