import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/reusable_widgets/text/text_widget.dart';

class FormPages extends StatelessWidget {
  final String pageTitle;
  final Widget form;
  final bool? isSignInOrSignUp;

  const FormPages({
    super.key,
    required this.pageTitle,
    required this.form,
    this.isSignInOrSignUp,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              PageTitleWidget(pageTitle: pageTitle),
              const SizedBox(height: 10.0),
              SingleChildScrollView(child: form),
            ],
          ),
        ),
      ],
    );
  }
}
