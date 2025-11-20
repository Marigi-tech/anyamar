import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final bool? isPassword;
  final String? hintText;
  final TextEditingController? fieldController;
  const TextInputWidget({
    super.key,
    this.isPassword,
    this.hintText,
    this.fieldController,
  });

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.fieldController,
      keyboardType: widget.isPassword == true
          ? TextInputType.visiblePassword
          : TextInputType.text,
      obscureText: widget.isPassword == true ? true : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: widget.hintText,
        suffix: widget.isPassword == true
            ? MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    //TODO: Use Riverpod to change state
                  },
                  child: Icon(Icons.remove_red_eye),
                ),
              )
            : Text(''),
      ),
    );
  }
}
