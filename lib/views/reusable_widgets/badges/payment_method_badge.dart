import 'package:anyamar/commons/exports.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodBadge extends StatelessWidget {
  final PaymentMethods? method;

  const PaymentMethodBadge({this.method, super.key});

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;

    switch (method) {
      case PaymentMethods.bank:
        background = const Color(0xFFFFF0D9);
        foreground = const Color(0xFFE58900);
        break;

      case PaymentMethods.cash:
        background = const Color.fromARGB(255, 207, 220, 250);
        foreground = AppColors.primaryBlue;
        break;

      case PaymentMethods.mpesa:
        background = const Color(0xFFE1F7E9);
        foreground = const Color(0xFF168D49);

      default:
        background = const Color.fromARGB(255, 247, 237, 232);
        foreground = AppColors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        method?.label ?? '',
        style: GoogleFonts.inter(
          fontSize: 10,
          color: foreground,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
