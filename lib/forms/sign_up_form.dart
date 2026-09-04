import 'package:anyamar/commons/exports.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String userTypeController = '';
  UserType? selectedUserType;
  Color? textColor;
  final _formKey = GlobalKey<FormState>();
  bool isSuccess = false;
  String? errorMessage;
  AppUser? createdUser;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ============================================================
  // REGISTER USER METHOD
  // ============================================================
  Future<void> _registerUser() async {
    try {
      UserCredential authUser = await ref
          .read(authServiceProvider)
          .createUser(
            email: emailController.text,
            password: passwordController.text.trim(),
          );

      setState(() {
        isSuccess = true;
        createdUser = AppUser(
          userId: authUser.user!.uid,
          userName: nameController.text,
          userEmail: emailController.text.trim(),
          userPassword: passwordController.text.trim(),
          userType: selectedUserType!.label,
          registrationDate: DateTime.now(),
        );
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.code;
        isSuccess = false;
      });
    }
  }

  // ============================================================
  //REDIRECT TO DASHBOARD
  // ============================================================
  Future<void> _redirectToDashboard() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => WidgetTree()),
    );
  }

  // ============================================================
  // DELETE FROM AUTHENTICATION
  // ============================================================
  Future<void> _deleteFromAuthentication() async {
    try {
      await ref
          .read(authServiceProvider)
          .deleteAccount(
            email: emailController.text,
            password: passwordController.text.trim(),
          );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.code;
        isSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormPages(
      pageTitle: 'Create account',
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
              // FULL NAME
              // ============================================================
              FormLabel(label: 'Full name', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: nameController,
                keyboardType: TextInputType.text,
                hintText: 'Enter your full name',
                customValidator: validateUserName,
              ),
              SizedBox(height: 15.0),
              // ============================================================
              // EMAIL ADDRESS
              // ============================================================
              FormLabel(label: 'Email address', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Enter email address',
                customValidator: validateEmail,
              ),
              SizedBox(height: 15.0),
              // ============================================================
              // USER TYPE
              // ============================================================
              FormLabel(label: 'User type', isRequired: true),
              SizedBox(height: 6),
              DropdownButtonFormField<UserType>(
                hint: Text(
                  'Select user type',
                  style: CustomInputDecoration.textInputDecoration().hintStyle,
                ),
                decoration: CustomInputDecoration.textInputDecoration(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: UserType.values.map((user) {
                  return DropdownMenuItem(value: user, child: Text(user.label));
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Select an option';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    userTypeController = value!.label;
                    selectedUserType = value;
                  });
                },
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
              // ============================================================
              // CONFIRM PASSWORD
              // ============================================================
              FormLabel(label: 'Confirm password', isRequired: true),
              SizedBox(height: 6),
              FormFieldWidget(
                controller: confirmPasswordController,
                keyboardType: TextInputType.text,
                hintText: 'Confirm password',
                isPassword: true,
                customValidator: validatePassword,
              ),

              SizedBox(height: 15.0),
              //? ============================================================
              //? ALREADY HAVE AN ACCOUNT
              //? ============================================================
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
              Text(
                errorMessage ?? '',
                style: TextStyle(
                  color: isSuccess
                      ? AppColorsConstant.greenColor
                      : AppColorsConstant.redColor,
                ),
              ),
              SizedBox(height: 50.0),
              // ============================================================
              // SIGN USER UP
              // ============================================================
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (_formKey.currentState!.validate() &&
                      selectedUserType != null) {
                    await _registerUser();
                    //If user is succesfully authenticated
                    final db = DbService(); //instance of db
                    if (isSuccess && createdUser != null) {
                      // add user to db
                      try {
                        await db.createUser(createdUser!).then((value) {
                          if (value != null) {
                            setState(() {
                              isSuccess = true;
                              errorMessage = 'User created succesfully';
                            });
                            //Redirect to user dashboard
                            _redirectToDashboard();
                          }
                        });
                      } catch (e) {
                        // if adding user to db fails // remove user from authentication
                        _deleteFromAuthentication();
                        setState(() {
                          errorMessage = e.toString();
                        });
                      }
                    } else {
                      setState(() {
                        errorMessage = 'Authentication failed';
                      });
                    }
                  }
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
