import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/dashboard_init/dashboard_widget.dart';
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/initial_pages/email_verification.dart';
import 'package:anyamar/views/pages/initial_pages/landing_page/landing_page.dart';
import 'package:anyamar/views/reusable_widgets/loading_widget/loading_widget.dart';

class WidgetTree extends ConsumerStatefulWidget {
  const WidgetTree({super.key});

  @override
  ConsumerState<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends ConsumerState<WidgetTree> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        Widget widget;
        if (snapshot.connectionState == ConnectionState.waiting &&
            authService.currentUser == null) {
          return LoadingScreen();
        }
        // if (snapshot.hasData && authService.currentUser != null) {
        //   widget = DashboardWidget();
        // }
        else if (snapshot.hasData && snapshot.data?.emailVerified == true) {
          widget = DashboardWidget();
        } else if (snapshot.hasData && snapshot.data?.emailVerified != true) {
          widget = EmailVerifiationScreen();
        } else {
          widget = LandingPage();
        }
        return widget;
      },
    );
    // return currentUser != null
    //     //todo: complete this
    //     // ? currentUser.emailVerified == true
    //     ? DashboardWidget(webPages: webPages)
    //     // : EmailVerificationPage()
    //     : LandingPage();
  }
}
