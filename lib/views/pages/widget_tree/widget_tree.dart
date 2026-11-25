import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/dashboard_init/dashboard_page.dart';
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/initial_pages/email_verification.dart';
import 'package:anyamar/views/reusable_widgets/loading_widget/loading_widget.dart';

class WidgetTree extends ConsumerStatefulWidget {
  const WidgetTree({super.key});

  @override
  ConsumerState<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends ConsumerState<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);

    return StreamBuilder<User?>(
      stream: authService.userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            authService.currentUser == null) {
          return LoadingScreen();
        }

        final user = snapshot.data;

        if (user == null) {
          return LandingPage();
        }

        if (user.emailVerified) {
          return DashboardWidget();
        }

        return EmailVerifiationScreen();
      },
    );
  }
}
