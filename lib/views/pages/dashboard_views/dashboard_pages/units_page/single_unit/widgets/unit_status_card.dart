import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_utilities.dart';

class UnitStatusCard extends ConsumerWidget {
  final bool isOccupied;
  const UnitStatusCard({super.key, required this.isOccupied});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClearButtonWidget(
          iconData: isOccupied
              ? CupertinoIcons.checkmark
              : CupertinoIcons.xmark,
          iconBackgroundColor: isOccupied
              ? AppColors.lightGreen
              : AppColors.red,
          title: 'Unit Status',
          description: isOccupied ? 'Occupied' : 'Vacant',
        ),
      ],
    );
  }
}
