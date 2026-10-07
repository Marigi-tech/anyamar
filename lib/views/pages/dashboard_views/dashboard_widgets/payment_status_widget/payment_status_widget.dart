import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/payment_status_widget/payment_donut_painter.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentStatusCard extends ConsumerWidget {
  const PaymentStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(appDataProvider);
    return DashboardCardWidget(
      cardTitle: 'Payment Status',

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                height: 170,
                child: CustomPaint(
                  painter: PaymentDonutPainter(),
                  child: const Center(child: SizedBox()),
                ),
              ),

              const SizedBox(width: 30),

              Expanded(
                child: Column(
                  children: const [
                    _StatusRow(
                      color: Color(0xFF2DB65B),
                      title: 'Complete',
                      value: '21 (70%)',
                    ),
                    _StatusRow(
                      color: Color(0xFFECA018),
                      title: 'Partial',
                      value: '3 (10%)',
                    ),
                    _StatusRow(
                      color: Color(0xFFEF4B4B),
                      title: 'Pending',
                      value: '4 (13%)',
                    ),
                    _StatusRow(
                      color: Color(0xFFADB3BC),
                      title: 'Excess',
                      value: '1 (7%)',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends ConsumerWidget {
  final Color color;
  final String title;
  final String value;

  const _StatusRow({
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: themeIsDark == true
                    ? AppColors.whiteColor
                    : const Color(0xFF39465A),
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: themeIsDark == true
                  ? AppColors.whiteColor
                  : const Color(0xFF27344A),
            ),
          ),
        ],
      ),
    );
  }
}

// class PaymentStatusCard extends ConsumerWidget {
//   const PaymentStatusCard({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeIsDark = ref.watch(themeIsDarkProvider);
//     return DashboardCardWidget(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             'Payment Status',
//             style: GoogleFonts.inter(
//               color: themeIsDark == true
//                   ? AppColors.whiteColor
//                   : const Color(0xFF11213D),
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Column(
//           //   children: [
//           Center(
//             child: SizedBox(
//               width: 150,
//               height: 170,
//               child: CustomPaint(
//                 painter: PaymentDonutPainter(),
//                 child: const Center(child: SizedBox()),
//               ),
//             ),
//           ),

//           const SizedBox(height: 10),

//           // Column(
//           //   children: const [
//           _StatusRow(
//             color: Color(0xFF2DB65B),
//             title: 'Complete',
//             value: '21 (70%)',
//           ),
//           _StatusRow(
//             color: Color(0xFFECA018),
//             title: 'Partial',
//             value: '3 (10%)',
//           ),
//           _StatusRow(
//             color: Color(0xFFEF4B4B),
//             title: 'Pending',
//             value: '4 (13%)',
//           ),
//           _StatusRow(
//             color: Color(0xFFADB3BC),
//             title: 'Excess',
//             value: '1 (7%)',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StatusRow extends StatelessWidget {
//   final Color color;
//   final String title;
//   final String value;

//   const _StatusRow({
//     required this.color,
//     required this.title,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 10,
//             height: 10,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               style: GoogleFonts.inter(
//                 fontSize: 11,
//                 color: const Color(0xFF39465A),
//               ),
//             ),
//           ),
//           Text(
//             value,
//             style: GoogleFonts.inter(
//               fontSize: 11,
//               color: const Color(0xFF27344A),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
