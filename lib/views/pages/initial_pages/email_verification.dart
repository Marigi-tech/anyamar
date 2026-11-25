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
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  bool isChecking = false;
  bool isResending = false;
  Future<void> _redirectToWidgetTree() async {
    LazyLoader lazyLoader = LazyLoader(context: context);
    lazyLoader.showLoader();
    await Navigator.of(
      context,
    ).pushReplacement((MaterialPageRoute(builder: (_) => WidgetTree())));
    lazyLoader.hideLoader();
  }

  Future<void> _checkVerification() async {
    LazyLoader lazyLoader = LazyLoader(context: context);
    lazyLoader.showLoader();
    setState(() => isChecking = true);

    try {
      await FirebaseAuth.instance.currentUser?.reload();

      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        await _redirectToWidgetTree();
      } else {
        displaySnackBar(
          context,
          'Your email has not been verfied yet. \n Please check your emails and click the verification link',
          AppColors.darkElevatedCard,
          false,
        );
      }
    } catch (e) {
      debugPrint('Verification check failed: $e');
    } finally {
      if (mounted) {
        setState(() => isChecking = false);
      }
      lazyLoader.hideLoader();
    }
  }

  Future<void> _resendVerification() async {
    LazyLoader lazyLoader = LazyLoader(context: context);
    lazyLoader.showLoader();
    setState(() => isResending = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        if (!mounted) return;

        displaySnackBar(
          context,
          'Email verification link sent succesfully',
          AppColors.darkElevatedCard,
          true,
        );
      }
    } catch (e) {
      debugPrint('Resending verification failed: $e');
    } finally {
      if (mounted) {
        setState(() => isResending = false);
      }
      lazyLoader.showLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    bool isDark = ref.watch(themeIsDarkProvider);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.mark_email_unread_outlined,
            size: 70,
            color: LandingHeroColors.muted,
          ),
          const SizedBox(height: 40),
          Text(
            'Verify your email address',
            style: CustomTextStyles.cardDescriptionStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
            ),
          ),
          SizedBox(height: 6),
          Container(
            width: 190,
            height: 2,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 4, 73, 221),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            softWrap: true,
            text: TextSpan(
              text: 'We have sent a verification link to ',
              children: [
                TextSpan(
                  text: email,
                  style: CustomTextStyles.cardDescriptionStyle.copyWith(
                    color: AppColors.primaryBlue,
                    fontSize: 16,
                    letterSpacing: -0.4,
                  ),
                ),
                TextSpan(text: '. Please verify your email before continuing.'),
              ],

              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                color: isDark ? AppColors.darkText : LandingHeroColors.muted,
                fontSize: 16,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),

          const SizedBox(height: 24),
          ElevatedButtonWidget(
            isClear: true,
            onButtonPressedCallBack: () =>
                isChecking ? null : _checkVerification,
            buttonTitle: isChecking ? 'Checking' : "I've verified my email",
          ),
          SizedBox(height: 10.0),
          ElevatedButtonWidget(
            onButtonPressedCallBack: () =>
                isResending ? null : _resendVerification,
            buttonTitle: isResending
                ? 'Sending...'
                : 'Resend verification email',
            buttonIcon: Icon(CupertinoIcons.envelope),
          ),
        ],
      ),
    );
  }
}
