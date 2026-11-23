import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/widgets/hero/features/hero_content.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/widgets/hero/features/hero_orbit.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/widgets/landing_navigation.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/widgets/navbar_drawer.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // Subtle glowing animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = ref.watch(themeIsDarkProvider);
    // final showDrawer = ref.watch(drawerProvider);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark
          ? const Color(0xFF07091F)
          : AppColors.lightBackground,
      endDrawer: Drawer(
        elevation: 6,
        child: NavBarDrawer(scaffoldKey: _scaffoldKey),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth <= 950;

          return Stack(
            fit: StackFit.expand,
            children: [
              //================================
              // Background
              //================================
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? const [
                              Color(0xFF080A24),
                              Color(0xFF090C29),
                              Color(0xFF05071D),
                            ]
                          : [
                              AppColors.lightBackground,
                              AppColors.lightCard,
                              AppColorsConstant.kPrimaryColor,
                            ],
                    ),
                  ),
                ),
              ),

              //================================
              // Decorative background glows
              //================================
              Positioned(
                top: -100,
                right: -100,
                child: _backgroundGlow(
                  size: 350,
                  color: const Color(0xFF3431B9),
                ),
              ),

              Positioned(
                bottom: -180,
                left: -130,
                child: _backgroundGlow(
                  size: 350,
                  color: const Color(0xFF292EAE),
                ),
              ),

              //================================
              // Main content
              //================================
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 22 : constraints.maxWidth * 0.07,
                    vertical: isMobile ? 12 : 20,
                  ),

                  child: Column(
                    children: [
                      // Navigation
                      LandingNavigation(
                        isMobile: isMobile,
                        scaffoldKey: _scaffoldKey,
                      ),

                      SizedBox(height: isMobile ? 20 : 25),

                      // Hero takes remaining screen height
                      Expanded(
                        child: isMobile
                            ? _buildMobileHero()
                            : _buildDesktopHero(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  //========================================
  // Background glow
  //========================================

  Widget _backgroundGlow({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.04),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  //========================================
  // Desktop hero
  //========================================

  Widget _buildDesktopHero() {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 5, child: HeroContent(isMobile: false)),

            const SizedBox(width: 30),

            Expanded(
              flex: 5,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FeatureOrbitIllustration(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //========================================
  // Mobile hero
  //========================================

  Widget _buildMobileHero() {
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              child: HeroContent(isMobile: true),
            ),
          );
        },
      ),
    );
  }
}
