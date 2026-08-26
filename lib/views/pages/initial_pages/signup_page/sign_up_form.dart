import 'package:anyamar/data/models/users/app_user.dart';
import 'package:anyamar/data/services/auth_service.dart';
import 'package:anyamar/data/services/db_user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/models/enums/user_type_enum.dart';
import 'package:anyamar/views/pages/initial_pages/form_pages.dart';
import 'package:anyamar/views/pages/initial_pages/signin_page/login_page.dart';
import 'package:anyamar/views/pages/widget_tree/widget_tree.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/form_label.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:anyamar/views/reusable_widgets/social_icons_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          userType: userTypeController,
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

  //Redirection to user dashboard
  Future<void> _redirectToDashboard() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => WidgetTree()),
    );
  }

  //Delete user from authentication
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
      // errorMessageWidget(errorMessage = errorMessage, isSuccess = isSuccess);
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
              //User Name
              FormLabel(label: 'Full name', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Enter your full name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15.0),

              // UserEmail Adress
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

              //User Type
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
                  });
                  // ref.read(selectedPropertyProvider.notifier).state = value;
                },
              ),
              SizedBox(height: 15.0),

              //Password -----
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
                    return 'Enter password';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15.0),
              //Confirm password
              FormLabel(label: 'Confirm password', isRequired: true),
              SizedBox(height: 6),
              TextFormField(
                controller: confirmPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                decoration: CustomInputDecoration.textInputDecoration(
                  hintText: 'Confirm password',
                  isPassword: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter password';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15.0),
              //? Sign in option
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
              //? ------ Log in button ------
              ColorButtonWidget(
                onPressedCallBack: () async {
                  if (_formKey.currentState!.validate()) {
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
