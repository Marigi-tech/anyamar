import 'package:anyamar/commons/exports.dart';

class RecentPaymentsCard extends ConsumerWidget {
  const RecentPaymentsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return DashboardCardWidget(
    //   cardTitle: 'Recent Payments',
    //   buttonWidget1: TextButton(
    //     onPressed: () {},
    //     child: Text(
    //       'View all',
    //       style: GoogleFonts.inter(
    //         color: const Color(0xFF2469DB),
    //         fontSize: 12,
    //       ),
    //     ),
    //   ),
    //   child:
    return FinancesTable(isFromHomePage: true);

    // child: Column(
    //   children: [
    //     // Header
    //     _PaymentHeader(),

    //     const Divider(height: 1),

    //     for (final payment in records) ...[
    //       _PaymentRow(record: payment),
    //       const Divider(height: 1),
    //     ],
    //   ],
  }
}
