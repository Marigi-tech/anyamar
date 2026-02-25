// import 'package:flutter/material.dart';
// import 'package:test_app/views/widgets/text/text_widget.dart';

// class FormPages extends StatelessWidget {
//   final String pageTitle;
//   final Form form;
//   final bool? isSignInOrSignUp;

//   const FormPages({
//     super.key,
//     required this.pageTitle,
//     required this.form,
//     this.isSignInOrSignUp,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//       height: double.infinity,
//       child:
//           // ----- TOP SECTION -----
//           Column(
//             children: [
//               PageTitleWidget(pageTitle: pageTitle),
//               SizedBox(height: 20.0),
//               // Form
//               form,
//             ],
//           ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:test_app/views/widgets/text/text_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              PageTitleWidget(pageTitle: pageTitle),
              SizedBox(height: 20.0),
              // Form
              form,
            ],
          ),
        ),
      ],
    );
  }
}
