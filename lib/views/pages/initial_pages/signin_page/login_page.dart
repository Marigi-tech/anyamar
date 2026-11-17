import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/forms/login_page_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_shell_web.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormShellWeb(webForm: LogInPageForm(), photoRight: false);
    // return Scaffold(
    //   // backgroundColor: backgroundColor,
    //   body: Container(
    //     height: double.infinity,
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         begin: Alignment.bottomLeft,
    //         end: Alignment.topRight,
    //         colors: [
    //           AppColors.buttonBlueColor.withValues(alpha: 0.95),
    //           AppColors.buttonBlueColor.withValues(alpha: 0.45),
    //           backgroundColor,
    //           backgroundColor,
    //           backgroundColor.withValues(alpha: 0.95),
    //           backgroundColor.withValues(alpha: 0.25),
    //           backgroundColor.withValues(alpha: 0.35),
    //           AppColors.buttonBlueColor.withValues(alpha: 0.45),
    //           AppColors.buttonBlueColor.withValues(alpha: 0.95),
    //         ],
    //         stops: const [0.0, 0.18, 0.24, 0.31, 0.42, 0.58, 0.82, 0.94, 1.0],
    //       ),
    //     ),

    //     child: Responsiveness.isMobile(context)
    //         ? LoginPageMobile()
    //         : LogInPageWeb(),
    //   ),
    // );
  }
}
