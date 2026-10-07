import 'package:anyamar/commons/exports.dart';

class FormItemWidget extends StatelessWidget {
  final String label;
  final bool? required;
  final Widget child;
  const FormItemWidget({
    super.key,
    required this.label,
    this.required,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(label: label, isRequired: required),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
