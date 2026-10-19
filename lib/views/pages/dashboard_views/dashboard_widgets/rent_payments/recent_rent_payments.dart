import 'package:anyamar/commons/exports.dart';

class RecentPaymentsCard extends ConsumerWidget {
  const RecentPaymentsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FinancesTable(isFromHomePage: true, introText: 'finances');
  }
}
