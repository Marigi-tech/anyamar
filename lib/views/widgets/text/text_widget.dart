import 'package:flutter/material.dart';

class PageTitleWidget extends StatelessWidget {
  final String pageTitle;
  const PageTitleWidget({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          pageTitle,
          style: TextStyle(fontSize: 30, fontFamily: 'Lato'),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
