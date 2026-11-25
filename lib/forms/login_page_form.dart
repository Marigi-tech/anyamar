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
    final lazyLoader = LazyLoader(context: context);

    final isDarkMode = ref.read(themeIsDarkProvider);

    final dialogColor = isDarkMode
        ? AppColors.darkElevatedCard
        : AppColors.lightCard;

    lazyLoader.showLoader();

    try {
      await ref
          .read(authServiceProvider)
          .signInUser(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      if (!mounted) return;

      final currentUser = ref.read(authServiceProvider).currentUser;

      if (currentUser != null) {
        setState(() {
          isSuccess = true;
          errorMessage = '';
        });

        await _redirectToDashboard().whenComplete(
          () => lazyLoader.hideLoader(),
        );

        return;
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      final code = e.code == 'invalid-credential'
          ? 'Incorrect email or password'
          : e.message ?? e.code;

      setState(() {
        isSuccess = false;
        errorMessage = code;
      });

      // Allow the loader to disappear before displaying the popup.
      await Future.delayed(const Duration(milliseconds: 100));

      if (!mounted) return;

      displaySnackBar(context, code, dialogColor, false);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSuccess = false;
        errorMessage = 'Something went wrong. Please try again.';
      });

      await Future.delayed(const Duration(milliseconds: 100));

      if (!mounted) return;
      await lazyLoader.hideLoader();
      displaySnackBar(context, errorMessage ?? '', dialogColor, false);
    } finally {
      lazyLoader.hideLoader();
    }
  }

  //Redirection to user dashboard
  Future<void> _redirectToDashboard() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => WidgetTree()),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    emailController.clear();
    passwordController.clear();
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
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
                      textColor = AppColorsConstant.primaryColor;
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

              SizedBox(height: 30.0),
              // ==========================================================
              // SUBMIT BUTTON
              // ==========================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButtonWidget(
                    buttonTitle: 'Reset',
                    onButtonPressedCallBack: () {
                      _resetForm();
                    },
                    isClear: true,
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButtonWidget(
                    onButtonPressedCallBack: () async {
                      if (_formKey.currentState!.validate()) {
                        await _signInUser();
                      }
                    },
                    buttonTitle: 'Sign In',
                  ),
                ],
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
