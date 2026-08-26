import 'package:flutter/material.dart';
import 'package:anyamar/views/pages/initial_pages/form_shell_web.dart';
import 'package:anyamar/views/pages/initial_pages/signin_page/login_page_form.dart';

class LogInPageWeb extends StatefulWidget {
  const LogInPageWeb({super.key});

  @override
  State<LogInPageWeb> createState() => _LogInPageWebState();
}

class _LogInPageWebState extends State<LogInPageWeb> {
  @override
  Widget build(BuildContext context) {
    return FormShellWeb(webForm: LogInPageForm());
  }
}
