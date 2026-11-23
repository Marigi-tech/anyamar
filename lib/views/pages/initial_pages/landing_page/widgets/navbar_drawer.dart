import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/widgets/brand_logo.dart';

class NavBarDrawer extends ConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NavBarDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);

    return Container(
      alignment: Alignment.topRight,
      width: 60,
      decoration: BoxDecoration(
        color: themeIsDark
            ? const Color(0xFF07091F)
            : AppColors.lightBackground,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.zero,

      // padding: const EdgeInsets.fromLTRB(15, 28, 10, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: CloseButton(
                onPressed: () => scaffoldKey.currentState?.closeEndDrawer(),
              ),
            ),
          ),
          SizedBox(height: 30),
          BrandLogo(),
          Spacer(),
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
          SizedBox(height: 20.0),
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
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
