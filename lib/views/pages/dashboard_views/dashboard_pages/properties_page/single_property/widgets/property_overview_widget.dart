import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/widgets/detail_column_widget.dart';

class PropertyOverviewWidget extends StatelessWidget {
  final Property property;
  const PropertyOverviewWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return DashboardCardWidget(
      cardTitle: 'Property Overview',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailColumnWidget(
            label: 'Property Name',
            value: property.propertyName,
          ),

          DetailColumnWidget(
            label: 'Location',
            value: property.propertyLocation,
          ),

          if (property.propertyManager != null)
            DetailColumnWidget(
              label: 'Property Manager',
              value: property.propertyManager!.personName,
            ),
          if (property.lastUpdatedDate != null)
            DetailColumnWidget(
              label: 'Last updated',
              value: formatPrettyDate(property.lastUpdatedDate!),
            ),
        ],
      ),
    );
  }
}
