import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/data_sets/units.dart';
import 'package:test_app/views/pages/information_pages/single_property/single_property_page.dart';

import 'package:test_app/views/tables/view_chevron_card.dart';

TableRow buildHeaderRow() {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Property", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Location", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text(
          "Managed By",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Units", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
    ],
  );
}

TableRow buildDataRow(Property property, int index, BuildContext context) {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          '$index',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          property.propertyName,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          property.propertyLocation,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          property.propertyManager,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          '${units.where((element) => element.propertyId == property.propertyId).length}',

          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: ViewChevronCard(
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

class PropertiesTable extends StatelessWidget {
  final List<Property> myProperties;
  const PropertiesTable({super.key, required this.myProperties});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Table(
        border: TableBorder.symmetric(
          outside: BorderSide.none,
          inside: BorderSide(
            color: AppColorsConstant.blueGreyColor,
            width: 0.09,
          ),
        ),
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(2),
          4: FlexColumnWidth(1),
          5: FlexColumnWidth(1),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Header Row
          buildHeaderRow(),

          ...myProperties.asMap().entries.map((entry) {
            int index = entry.key; // 0, 1, 2, ...
            Property property = entry.value;
            return buildDataRow(
              property,
              index + 1,
              context,
            ); // pass 1-based index
          }),
        ],
      ),
    );
  }
}
