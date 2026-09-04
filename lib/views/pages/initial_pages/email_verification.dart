import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/landing_page.dart';

class EmailVerifiationScreen extends StatelessWidget {
  const EmailVerifiationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //check if user is verified or not
    //if verified take them to the home screen
    //if not stick here till verified
    return Scaffold(
      body: Responsiveness.isMobile(context)
          ? MobileFormWidget(
              form: VerificationScreen(),
              formTitle: 'Email verification',
              hasSocialOptions: false,
            )
          : WebFormWidget(
              form: VerificationScreen(),
              formTitle: 'Email verification',
              hasSocialOptions: false,
            ),
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
  Widget _messageWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
      child: Text(
        message,
        style: CustomTextStyles.cardExtraDescriptionStyle.copyWith(
          color: isSuccess
              ? AppColorsConstant.greenColor
              : AppColorsConstant.redColor,
        ),
      ),
    );
  }

  void _homePage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LandingPage()));
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final imagePath = authService.currentUser?.emailVerified == true
        ? 'assets/images/face.png'
        : 'assets/images/email.png';
    // return ValueListenableBuilder(
    //   valueListenable: authServiceProvider,
    //   builder: (context, authService, child) {
    return authService.currentUser?.emailVerified == true
        ? WidgetTree() // display home screen
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(image: AssetImage(imagePath), height: 60, width: 60),
                    SizedBox(height: 10.0),
                    Text(
                      authService.currentUser?.emailVerified == true
                          ? 'Your account has been verified'
                          : 'Click the button below to receive an email verification link',
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    _messageWidget(),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorButtonWidget(
                      buttonColor: AppColorsConstant.blueColor,
                      onPressedCallBack: () async {
                        if (authService.currentUser?.emailVerified == true) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => WidgetTree()),
                          );
                        } else {
                          //verify email
                          try {
                            await authService.verifyEmail();

                            setState(() {
                              isSuccess = true;
                              message = 'Email verified';
                            });
                            _homePage();
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              message = e.code;
                              isSuccess = false;
                            });
                          }
                        }
                      },
                      buttonTitle:
                          authService.currentUser?.emailVerified == true
                          ? 'Proceed to homepage'
                          : 'Verify your account',
                    ),
                    SizedBox(height: 30),
                    //Temporarily log out
                    ColorButtonWidget(
                      buttonColor: AppColorsConstant.orangeColor,
                      onPressedCallBack: () async {
                        await AuthService().signOutUser();
                      },
                      buttonTitle: 'back to home page  ->',
                    ),
                  ],
                ),
              ),
            ],
          );

    //   },
    // );
  }
}
