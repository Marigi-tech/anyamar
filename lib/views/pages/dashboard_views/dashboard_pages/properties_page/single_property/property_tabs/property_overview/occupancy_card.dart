import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_overview/occupancy_rate_view.dart';

class OccupancyCard extends ConsumerWidget {
  final Property property;
  const OccupancyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appDataProvider);

    //Get occupied units
    List<Unit> occupiedUnits = appData.units
        .where((element) => element.isOccupied == true)
        .toList();
    //Get units
    List<Unit> propertyUnits = appData.units
        .where((element) => element.propertyId == property.propertyId)
        .toList();

    final occupancy = getOccupancyInfo(
      occupiedUnits.length.toDouble(),
      propertyUnits.length.toDouble(),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Occupancy Rate: ', style: CustomTextStyles.cardDescriptionStyle),
        Text(
          occupancy.text,

          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 25,
            color: occupancy.color,
          ),
        ),
      ],
    );
  }
}
