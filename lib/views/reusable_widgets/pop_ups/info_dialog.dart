import 'package:flutter/material.dart';

class InformationDialogWidget extends StatelessWidget {
  final Widget informationContent;
  const InformationDialogWidget({super.key, required this.informationContent});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: informationContent,
    );
  }
}
