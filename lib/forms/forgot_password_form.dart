import 'package:anyamar/commons/exports.dart';

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
              FormFieldWidget(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Enter email address',
                customValidator: validateEmail,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
              ),
              SizedBox(height: 30.0),
              //? send
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (_formKey.currentState!.validate()) {
                    final auth = AuthService();
                    LazyLoader lazyLoader = LazyLoader(context: context);
                    lazyLoader.showLoader();
                    try {
                      final value = await auth.sendPasswordResetEmail(
                        email: emailController.text.trim(),
                      );
                      if (value == true) {
                        displaySnackBar(
                          context,
                          'A reset password link has been sent to your email address',
                          AppColorsConstant.greenColor,
                        );
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) => LoginPage()));
                      }
                    } catch (e) {
                      if (context.mounted) {
                        displaySnackBar(
                          context,
                          'Error $e occured when sending the reset password link has been sent to your email address',
                          AppColorsConstant.redColor,
                        );
                      }
                    } finally {
                      lazyLoader.hideLoader();
                    }
                  }
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
