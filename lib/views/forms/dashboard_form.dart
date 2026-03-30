import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/responsiveness/responsiveness.dart';
import 'package:test_app/views/pages/initial_pages/form_shell_web.dart';

class DashboardForm extends ConsumerWidget {
  final Widget form;
  const DashboardForm({required this.form, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Responsiveness.isMobile(context)
          ? DashboardFormMobile(form: form)
          : DashboardFormWeb(form: form),
    );
  }
}

class DashboardFormMobile extends StatelessWidget {
  final Widget form;
  const DashboardFormMobile({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: form,
    );
  }
}

class DashboardFormWeb extends StatelessWidget {
  final Widget form;
  const DashboardFormWeb({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return FormShellWeb(webForm: form);
  }
}
