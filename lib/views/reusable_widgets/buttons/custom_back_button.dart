import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 06, left: 20),
      child: Align(alignment: Alignment.topLeft, child: BackButton()),
    );
  }
}
