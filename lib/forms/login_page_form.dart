import 'package:anyamar/commons/exports.dart';

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
  bool? isSuccess;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  // ============================================================
  // SIGN IN USER METHOD
  // ============================================================
  Future<void> _signInUser() async {
    try {
      await ref
          .read(authServiceProvider)
          .signInUser(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      final currentUser = ref.read(authServiceProvider).currentUser;
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
              // ============================================================
              // EMAIL ADDRESS
              // ============================================================
              FormLabel(label: 'Email address', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: emailController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                keyboardType: TextInputType.emailAddress,
                hintText: 'Enter email address',
                customValidator: validateEmail,
              ),
              SizedBox(height: 15.0),
              // ============================================================
              // PASSWORD
              // ============================================================
              FormLabel(label: 'Password', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: passwordController,
                keyboardType: TextInputType.text,
                hintText: 'Enter password',
                isPassword: true,
                customValidator: validatePassword,
              ),
              SizedBox(height: 15.0),
              // ==========================================================
              // FORGOT PASSWORD
              // ==========================================================
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
                  color: isSuccess == null
                      ? null
                      : isSuccess == true
                      ? AppColorsConstant.greenColor
                      : AppColorsConstant.redColor,
                ),
              ),
              SizedBox(height: 30.0),
              // ==========================================================
              // SUBMIT BUTTON
              // ==========================================================
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (_formKey.currentState!.validate()) {
                    await _signInUser();
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
