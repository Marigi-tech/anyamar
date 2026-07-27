import 'package:flutter/cupertino.dart';
import 'package:anyamar/views/reusable_widgets/text/text_widget.dart';

class FormPages extends StatelessWidget {
  final String pageTitle;
  final Form form;
  final bool? isSignInOrSignUp;

  const FormPages({
    super.key,
    required this.pageTitle,
    required this.form,
    this.isSignInOrSignUp,
  });

  //   @override
  //   Widget build(BuildContext context) {
  //     return Row(
  //       children: [
  //         Expanded(
  //           child: Column(
  //             children: [
  //               PageTitleWidget(pageTitle: pageTitle),
  //               SizedBox(height: 20.0),
  //               // Form
  //               SingleChildScrollView(child: form),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              PageTitleWidget(pageTitle: pageTitle),
              const SizedBox(height: 20.0),

              SingleChildScrollView(child: form),
            ],
          ),
        ),
      ],
    );
  }
}
