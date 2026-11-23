import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/finances_page/page_states/finances_table_page_state.dart';


// ============================================================
// BASE FINANCES PAGE
// ============================================================
class FinancesPage extends ConsumerWidget {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FinancesTablePage(introText: 'finances');
  }
}
