import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/initial_pages/form_shell_web.dart';
import 'dart:async';

class EmailVerifiationScreen extends ConsumerWidget {
  const EmailVerifiationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //check if user is verified or not
    //if verified take them to the home screen
    //if not stick here till verified
    return FormShellWeb(
      webForm: FormPages(
        pageTitle: 'Email verification',
        isSignInOrSignUp: false,
        form: VerificationScreen(),
      ),
      photoRight: true,
      imageAsset: 'assets/images/mosque.jpg',
    );
  }
}

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  String message = '';
  bool isSuccess = false;

  Timer? _verificationTimer;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();

    // Check Firebase every 5 seconds.
    _verificationTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkEmailVerification(),
    );
  }

  Future<void> _checkEmailVerification() async {
    if (!mounted || _isChecking) return;

    _isChecking = true;

    try {
      final authService = ref.read(authServiceProvider);

      final isVerified = await authService.reloadAndCheckEmailVerification();

      if (!mounted) return;

      if (isVerified) {
        _verificationTimer?.cancel();

        setState(() {
          isSuccess = true;
          message = 'Your email has been successfully verified!';
        });

        // No manual navigation is necessary.
        // WidgetTree will automatically display DashboardWidget.
      }
    } catch (e) {
      debugPrint('Email verification check failed: $e');
    } finally {
      _isChecking = false;
    }
  }

  @override
  void dispose() {
    _verificationTimer?.cancel();
    super.dispose();
  }

  // String message = '';
  // bool isSuccess = false;
  Widget _messageWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
      child: Text(
        message,
        style: CustomTextStyles.cardDescriptionStyle.copyWith(
          fontSize: 15,
          color: isSuccess
              ? AppColorsConstant.greenColor
              : AppColorsConstant.redColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final imagePath = authService.currentUser?.emailVerified == true
        ? 'assets/images/face.png'
        : 'assets/images/email.png';

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.0),
          Image(image: AssetImage(imagePath), height: 60, width: 60),
          SizedBox(height: 10.0),
          Text(
            authService.currentUser?.emailVerified == true
                ? 'Your account has been verified'
                : 'Click the button below to receive an email verification link',
            textAlign: TextAlign.center,
            style: CustomTextStyles.cardDescriptionStyle.copyWith(fontSize: 20),
          ),
          _messageWidget(),
          SizedBox(height: 30.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButtonWidget(
                onButtonPressedCallBack: () async {
                  final authService = ref.read(authServiceProvider);

                  try {
                    // First check whether the user has already verified their email.
                    final isVerified = await authService
                        .reloadAndCheckEmailVerification();

                    if (!mounted) return;

                    if (isVerified) {
                      _verificationTimer?.cancel();

                      setState(() {
                        isSuccess = true;
                        message = 'Your email has been successfully verified!';
                      });

                      return;
                    }

                    // If not verified, send another verification link.
                    await authService.verifyEmail();

                    if (!mounted) return;

                    setState(() {
                      isSuccess = true;
                      message =
                          'A verification link has been sent to your email.';
                    });
                  } on FirebaseAuthException catch (e) {
                    if (!mounted) return;

                    setState(() {
                      isSuccess = false;
                      message = e.message ?? e.code;
                    });
                  } catch (e) {
                    if (!mounted) return;

                    setState(() {
                      isSuccess = false;
                      message = 'Something went wrong. Please try again.';
                    });
                  }
                },

                buttonTitle: 'Send Link',
              ),
              SizedBox(width: 20),
              //       //Temporarily log out
              ElevatedButtonWidget(
                isClear: true,
                onButtonPressedCallBack: () async {
                  await AuthService().signOutUser();
                },
                buttonTitle: 'Back to home page  ->',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
