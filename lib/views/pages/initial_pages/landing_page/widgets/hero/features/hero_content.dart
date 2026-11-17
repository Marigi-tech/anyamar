import 'package:anyamar/commons/exports.dart';
//=============================================
// HERO CONTENT
//==============================================

class HeroContent extends ConsumerWidget {
  final bool isMobile;
  const HeroContent({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeIsDarkProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        SizedBox(height: isMobile ? 70.0 : 80.0),
        Text(
          'Property Management,\nSimplified.',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.lightText,
            fontSize: 46,
            height: 1.15,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
          ),
        ),

        const SizedBox(height: 22),

        Text(
          'Take control of your properties, tenants, '
          'rental payments and finances with one '
          'intuitive property management platform.',
          style: TextStyle(
            color: (isDark ? (Colors.white) : AppColors.lightText).withValues(
              alpha: 0.75,
            ),
            fontSize: 16,
            height: 1.8,
          ),
        ),

        const SizedBox(height: 32),

        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            ElevatedButtonWidget(
              buttonTitle: 'Get Started',
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 19),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              onButtonPressedCallBack: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => SignUpPage())),
            ),

            ElevatedButtonWidget(
              isOutlined: true,
              buttonTitle: 'Sign In',
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 19),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              onButtonPressedCallBack: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => LoginPage()));
              },
            ),
          ],
        ),

        const SizedBox(height: 45),

        // _buildStatistics(),
      ],
    );
  }
}
