import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/views/reusable_widgets/form_elements/input_decoration.dart';
import 'package:flutter/cupertino.dart';

class FormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final bool needsValidation;
  final VoidCallback? onPressedCallBack;
  final ValueChanged<String>? onChangedCallBack;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;

  const FormFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.needsValidation = true,
    this.onPressedCallBack,
    this.onChangedCallBack,
    this.inputFormatters,
    this.prefix,
  });

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  bool passwordIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPassword && passwordIsVisible,
      inputFormatters: [
        ...widget.inputFormatters ?? [],
      ],
      onTap: widget.onPressedCallBack,
      onChanged: widget.onChangedCallBack,
      decoration: CustomInputDecoration.textInputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,
        suffix: widget.isPassword
            ? MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      passwordIsVisible = !passwordIsVisible;
                    });
                  },
                  child: Icon(
                    passwordIsVisible
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    size: 18,
                  ),
                ),
              )
            : null,
      ),
      validator: (value) {
        if (widget.needsValidation &&
            (value == null || value.trim().isEmpty)) {
          return 'Enter ${widget.hintText}';
        }

        return null;
      },
    );
  }
}