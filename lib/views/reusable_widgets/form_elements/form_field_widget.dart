import 'package:anyamar/commons/exports.dart';

class FormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final bool required;
  final VoidCallback? onPressedCallBack;
  final ValueChanged<String>? onChangedCallBack;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final bool isReadOnly;
  final String? Function(String?)? customValidator;
  final bool? isMoneyField;

  const FormFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.required = true,
    this.onPressedCallBack,
    this.onChangedCallBack,
    this.inputFormatters,
    this.prefix,
    this.isReadOnly = false,
    this.customValidator,
    this.isMoneyField,
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
      obscureText: widget.isPassword && !passwordIsVisible,
      inputFormatters: [...widget.inputFormatters ?? []],
      onTap: widget.onPressedCallBack,
      onChanged: widget.onChangedCallBack,
      readOnly: widget.isReadOnly,

      decoration: CustomInputDecoration.textInputDecoration(
        hintText: widget.hintText,
        prefix: widget.prefix,

        prefixIcon: widget.isMoneyField == true
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                child: Text(' Ksh'),
              )
            : widget.prefix,
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
        final text = value?.trim() ?? '';

        // Required-field validation
        if (widget.required && text.isEmpty) {
          return 'Please ${widget.hintText}';
        }

        // Optional field + empty value = valid
        if (!widget.required && text.isEmpty) {
          return null;
        }

        // Custom validation
        if (widget.customValidator != null) {
          return widget.customValidator!(value);
        }

        return null;
      },
    );
  }
}

// class FormFieldWidget extends StatefulWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final bool isPassword;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final Widget? prefixIcon;
//   final bool needsValidation;
//   final VoidCallback? onPressedCallBack;
//   final ValueChanged<String>? onChangedCallBack;
//   final List<TextInputFormatter>? inputFormatters;
//   final Widget? prefix;
//   final bool? isReadOnly;
//   final String? Function(String?)? customValidator;
//   final Function(String?)? onSavedCallBack;
//   final bool? isMoneyField;
//   final bool required;
//   const FormFieldWidget({
//     super.key,
//     this.controller,
//     this.hintText,
//     this.isPassword = false,
//     this.keyboardType = TextInputType.text,
//     this.textInputAction = TextInputAction.next,
//     this.prefixIcon,
//     this.needsValidation = true,
//     this.onPressedCallBack,
//     this.onChangedCallBack,
//     this.inputFormatters,
//     this.prefix,
//     this.isReadOnly,
//     this.customValidator,
//     this.onSavedCallBack,
//     this.isMoneyField,
//     this.required = true,
//   });

//   @override
//   State<FormFieldWidget> createState() => _FormFieldWidgetState();
// }

// class _FormFieldWidgetState extends State<FormFieldWidget> {
//   bool passwordIsVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       required: widget.required,
//       controller: widget.controller,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       keyboardType: widget.keyboardType,
//       textInputAction: widget.textInputAction,
//       obscureText: widget.isPassword == true && passwordIsVisible == false
//           ? true
//           : false,
//       inputFormatters: [...widget.inputFormatters ?? []],
//       onTap: widget.onPressedCallBack,
//       onChanged: widget.onChangedCallBack,
//       onSaved: widget.onSavedCallBack,
//       readOnly: widget.isReadOnly ?? false,
//       decoration: CustomInputDecoration.textInputDecoration(
//         hintText: widget.hintText,
//         prefixIcon: widget.prefixIcon,
//         prefix: widget.isMoneyField == true
//             ? const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                 child: Text('Ksh'),
//               )
//             : widget.prefix,
//         suffix: widget.isPassword
//             ? MouseRegion(
//                 cursor: SystemMouseCursors.click,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       passwordIsVisible = !passwordIsVisible;
//                     });
//                   },
//                   child: Icon(
//                     passwordIsVisible
//                         ? CupertinoIcons.eye_slash
//                         : CupertinoIcons.eye,
//                     size: 18,
//                   ),
//                 ),
//               )
//             : null,
//       ),
//       validator: (value) {
//         if (widget.needsValidation && (value == null || value.trim().isEmpty)) {
//           return 'Enter ${widget.hintText}';
//         }

//         if (widget.customValidator != null) {
//           return widget.customValidator!(value);
//         }

//         return null;
//       },
//     );
//   }
// }
