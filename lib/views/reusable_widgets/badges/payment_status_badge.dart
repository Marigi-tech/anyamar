import 'package:anyamar/commons/exports.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSatusBadge extends StatelessWidget {
  final PaymentStatus status;

  const PaymentSatusBadge({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;

    switch (status) {
      case PaymentStatus.partial:
        background = const Color(0xFFFFF0D9);
        foreground = const Color(0xFFE58900);
        break;

      case PaymentStatus.pending:
        background = const Color(0xFFFFE4E4);
        foreground = const Color(0xFFE94444);
        break;

      case PaymentStatus.complete:
        background = const Color(0xFFE1F7E9);
        foreground = const Color(0xFF168D49);
        break;

      case PaymentStatus.excess:
        background = const Color.fromARGB(255, 217, 226, 255);
        foreground = AppColors.buttonBlueColor;
        break;

      default:
        background = const Color(0xFFFFF0D9);
        foreground = AppColors.amber;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        status.label,
        style: GoogleFonts.inter(
          fontSize: 10,
          color: foreground,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
