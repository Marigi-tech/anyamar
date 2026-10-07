import 'package:anyamar/commons/exports.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordNatureBadge extends StatelessWidget {
final bool isIncome;

  const RecordNatureBadge({required this.isIncome, super.key});

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;

    switch (isIncome) {
      case true:
        background = const Color(0xFFE1F7E9);
        foreground = const Color(0xFF168D49);
      case false:
        background = const Color(0xFFFFE4E4);
        foreground = const Color(0xFFE94444);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        isIncome == true ? 'Revenue' : 'Expense',
        style: GoogleFonts.inter(
          fontSize: 10,
          color: foreground,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
