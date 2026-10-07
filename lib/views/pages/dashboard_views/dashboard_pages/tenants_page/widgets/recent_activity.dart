import 'package:anyamar/commons/exports.dart';

class SinglePageRecentActivityWidget extends ConsumerWidget {
  final Tenant tenant;
  const SinglePageRecentActivityWidget({super.key, required this.tenant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardCardWidget(
      cardTitle: 'Recent Activity',
      child: ListTile(title: Text('Activity goes here')),

      //Update Tenant
    );
  }
}
