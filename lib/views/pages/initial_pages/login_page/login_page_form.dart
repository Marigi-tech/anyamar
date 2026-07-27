import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/views/pages/initial_pages/reset_password/forgot_password_page.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/pages/widget_tree/widget_tree.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';

import 'package:anyamar/views/reusable_widgets/social_icons_widget.dart';

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
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
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
                  if (_formKey.currentState!.validate()) {
                    //todo: actual logic
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => WidgetTree()),
                    );
                  }
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
