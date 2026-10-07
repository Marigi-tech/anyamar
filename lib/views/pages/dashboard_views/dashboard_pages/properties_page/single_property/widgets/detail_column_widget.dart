import 'package:anyamar/commons/exports.dart';

class DetailColumnWidget extends StatelessWidget {
  final String label;
  final String value;
  const DetailColumnWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 5),
          Text(value),
        ],
      ),
    );
  }
}
