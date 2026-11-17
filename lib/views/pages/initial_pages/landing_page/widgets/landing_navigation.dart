import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/widgets/brand_logo.dart';

class LandingNavigation extends ConsumerWidget {
  final bool isMobile;
  const LandingNavigation({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeIsDarkProvider);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 25,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1C1C39).withValues(alpha: 0.95)
            : AppColors.lightBackground.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          BrandLogo(),
          const Spacer(),

          if (!isMobile) ...[
            // _navItem('Home', true),
            // _navItem('Features', false),
            // _navItem('About', false),
            // _navItem('Contact', false),

            // const SizedBox(width: 25),
            ElevatedButtonWidget(
              buttonTitle: 'Sign Up',
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              onButtonPressedCallBack: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => SignUpPage())),
            ),
            const SizedBox(width: 15),
            ElevatedButtonWidget(
              buttonTitle: 'Sign In',
              isClear: true,
              onButtonPressedCallBack: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => LoginPage()));
              },
            ),
          ] else ...[
            IconButton(
              onPressed: () {
                //todo:Open drawer
              },
              icon: Icon(
                Icons.menu_rounded,
                color: isDark ? Colors.white : AppColors.darkCard,
                size: 27,
              ),
            ),
          ],
          SizedBox(width: 5),
          ThemeToggleWidget(),
        ],
      ),
    );
  }


}

class NavItemWidget extends ConsumerStatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onPressed;
  const NavItemWidget({
    super.key,
    required this.title,
    required this.isSelected,
    this.onPressed,
  });

  @override
  ConsumerState<NavItemWidget> createState() => NavItemWidgetState();
}

class NavItemWidgetState extends ConsumerState<NavItemWidget> {
  String title = '';
  bool isSelected = false;
  bool isHovered = false;

  @override
  void initState() {
    isSelected = widget.isSelected;
    title = widget.title;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = ref.watch(themeIsDarkProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () => widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  height: isHovered ? 2.0 : 1.0,
                  color: isSelected
                      ? isDarkMode
                            ? Colors.white
                            : AppColors.lightText
                      : isDarkMode
                      ? (Colors.white).withValues(alpha: 0.70)
                      : (AppColors.lightText).withValues(alpha: 0.70),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),

              SizedBox(height: isHovered ? 2 : 8),
              if (isHovered)
                Container(
                  width: 35,
                  height: 2,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 4, 73, 221),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),

              if (isSelected)
                Container(
                  width: 35,
                  height: 2,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6257FF),

                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
