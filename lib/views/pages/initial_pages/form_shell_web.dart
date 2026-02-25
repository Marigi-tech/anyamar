import 'package:test_app/data/constants/commons.dart';

class FormShellWeb extends StatelessWidget {
  final Widget webForm;
  const FormShellWeb({super.key, required this.webForm});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(padding: const EdgeInsets.all(20), child: webForm),
            ),
          ),
        ),
      ],
    );
  }
}
