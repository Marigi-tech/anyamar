import 'package:flutter/material.dart';
import 'package:test_app/constants/constants.dart';
import 'package:test_app/views/pages/initial_pages/form_pages.dart';
import 'package:test_app/views/reusable_widgets/buttons/button_widget.dart';
import 'package:test_app/views/reusable_widgets/form_elements/form_label.dart';
import 'package:test_app/views/reusable_widgets/form_elements/input_decoration.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return FormPages(
      pageTitle: 'Reset password',

      form: Form(
        key: _formKey,
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
              SizedBox(height: 30.0),
              //? send
              ColorButtonWidget(
                onPressedCallBack: () {
                  //todo: actual logic
                  if (_formKey.currentState!.validate()) {}
                },
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
