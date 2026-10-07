import 'package:flutter/material.dart';

class DetailRowWidget extends StatelessWidget {
  final String label;
  final String value;
  const DetailRowWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(width: 5),
          Text(value),
        ],
      ),
    );
  }
}
