import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/single_property/single_property_page.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/custom_data_table.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/view_chevron_card.dart';

// 1. Columns
List<DataColumn> buildHeaderColumns() {
  return const [
    DataColumn(
      label: Text("#", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Property", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Location", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Managed By", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Units", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

// 2. Data Rows
DataRow buildDataRow(
  Property property,
  int index,
  BuildContext context,
  List<Unit>? units,
) {
  return DataRow(
    onLongPress: () => Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SinglePropertyPage(property: property)),
    ),
    cells: [
      // Index Column
      DataCell(
        Text(
          '$index',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Property Name
      DataCell(
        Text(
          property.propertyName,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Property Location
      DataCell(
        Text(
          property.propertyLocation,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Property Manager
      DataCell(
        Text(
          property.propertyManager?['personName'] ?? '',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Filtered Units Count
      DataCell(
        Text(
          '${units?.where((element) => element.propertyId == property.propertyId).length}',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Navigation Action Card
      DataCell(
        ViewChevronCard(
          onPressedCallBack: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SinglePropertyPage(property: property),
              ),
            );
          },
        ),
      ),
    ],
  );
}

// 3. Table Widget
class PropertiesTable extends StatelessWidget {
  final List<Property> myProperties;
  final List<Unit> myUnits;
  const PropertiesTable({
    super.key,
    required this.myProperties,
    required this.myUnits,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDataTable(
      customDataColumns: buildHeaderColumns(),
      customDataRows: myProperties.asMap().entries.map((entry) {
        int index = entry.key;
        Property property = entry.value;
        return buildDataRow(property, index + 1, context, myUnits);
      }).toList(),
    );
  }
}
