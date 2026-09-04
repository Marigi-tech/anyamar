import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/date_format/date_format_model.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      formatPrettyDate(DateTime.now()),
      style: TextStyle(
        fontSize: 15,
        letterSpacing: 1.0,
        color: AppColorsConstant.darkBlueColor,
      ),
    );
  }
}
