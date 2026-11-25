import 'dart:async';

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
  Color? dialogColor;
  final _formKey = GlobalKey<FormState>();
  bool isSuccess = false;
  String? systemMessage;
  AppUser? createdUser;

  @override
  void initState() {
    super.initState();
  }

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
        systemMessage = e.code;
        isSuccess = false;
      });
    }
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
        systemMessage = e.code;
        isSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color dialogColor = isSuccess ? AppColors.lightGreen : AppColors.red;
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
              SizedBox(height: 15.0),
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
                  return DropdownMenuItem(
                    value: user,
                    child: Text(
                      user.label,
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  );
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
                      textColor = AppColors.primaryBlue;
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

              SizedBox(height: 10.0),
              // ============================================================
              // SIGN USER UP
              // ============================================================
              ElevatedButtonWidget(
                onButtonPressedCallBack: () async {
                  if (!_formKey.currentState!.validate() ||
                      selectedUserType == null) {
                    return;
                  }

                  final lazyLoader = LazyLoader(context: context);
                  lazyLoader.showLoader();

                  try {
                    await _registerUser();

                    if (!isSuccess || createdUser == null) {
                      throw Exception('Authentication failed.');
                    }

                    // Save user information in Firestore.
                    final db = DbService();
                    final result = await db.createUser(createdUser!);

                    if (result == null) {
                      throw Exception('Failed to save user information.');
                    }

                    // Send Firebase verification email.
                    await ref.read(authServiceProvider).sendEmailVerification();

                    if (!mounted) return;

                    // Take the user to the widget tree
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const WidgetTree()),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    //delete user from authentication
                    await _deleteFromAuthentication();

                    setState(() {
                      systemMessage = e.toString();
                      isSuccess = false;
                    });

                    displaySnackBar(
                      context,
                      'Authentication failed : ${systemMessage ?? ''}',
                      dialogColor,
                      isSuccess,
                    );
                  } finally {
                    lazyLoader.hideLoader();
                  }
                },
                buttonTitle: 'Create account',
              ),

              // ElevatedButtonWidget(
              //   onButtonPressedCallBack: () async {
              //     if (_formKey.currentState!.validate() &&
              //         selectedUserType != null) {
              //       LazyLoader lazyLoader = LazyLoader(context: context);
              //       lazyLoader.showLoader();
              //       await _registerUser();
              //       //* If user is succesfully authenticated
              //       //* Add them to database
              //       final db = DbService(); //!instance of db
              //       if (isSuccess && createdUser != null) {
              //         // add user to db
              //         try {
              //           await db.createUser(createdUser!).then((value) async {
              //             if (value != null) {
              //               setState(() {
              //                 isSuccess = true;
              //               });
              //               //Send email verification to email address
              //               await _sendEmailVerification();
              //               //Redirect to user dashboard
              //               _redirectToDashboard().whenComplete(
              //                 () => lazyLoader.hideLoader(),
              //               );
              //             }
              //           });
              //         } catch (e) {
              //           // if adding user to db fails // remove user from authentication
              //           _deleteFromAuthentication();
              //           setState(() {
              //             systemMessage = e.toString();
              //           });
              //           displaySnackBar(
              //             context,
              //             '$systemMessage',
              //             dialogColor,
              //             isSuccess,
              //           );
              //         } finally {
              //           lazyLoader.hideLoader();
              //         }
              //       } else {
              //         lazyLoader.hideLoader;
              //         setState(() {
              //           systemMessage = 'Authentication failed';
              //         });
              //         displaySnackBar(
              //           context,
              //           '$systemMessage',
              //           dialogColor,
              //           isSuccess,
              //         );
              //       }
              //     }
              //   },
              //   buttonTitle: 'Create account',
              // ),
              SizedBox(height: 15),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
