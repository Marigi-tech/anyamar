import 'package:flutter/material.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // ----- TOP SECTION -----
          Column(
            children: [
              PageTitleWidget(pageTitle: pageTitle),
              SizedBox(height: 20.0),
              // Form
              form,
            ],
          ),

          SizedBox(height: 10),
        ],
      ),
    );
  }
}
