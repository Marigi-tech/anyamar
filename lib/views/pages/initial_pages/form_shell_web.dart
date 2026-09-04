import 'package:anyamar/commons/exports.dart';

class FormShellWeb extends StatelessWidget {
  final Widget webForm;
  const FormShellWeb({super.key, required this.webForm});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: webForm,
          ),
        ),
      ],
    );
  }
}
