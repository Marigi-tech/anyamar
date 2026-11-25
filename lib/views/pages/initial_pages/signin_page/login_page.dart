import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/forms/login_page_form.dart';
import 'package:anyamar/views/pages/initial_pages/form_shell_web.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormShellWeb(webForm: LogInPageForm(), photoRight: false);
  }
}
