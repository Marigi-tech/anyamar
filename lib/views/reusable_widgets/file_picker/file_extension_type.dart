import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FileExtensionType extends StatelessWidget {
  final String path;
  const FileExtensionType({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: SvgPicture.asset(path, fit: BoxFit.contain),
    );
  }
}
