import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/data_sets/tenants.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/views/pages/information_pages/single_unit/single_unit_modal.dart';
import 'package:anyamar/views/reusable_widgets/information_badges/information_badge_widget.dart';
import 'package:anyamar/views/tables/custom_data_table.dart';
import 'package:anyamar/views/tables/view_chevron_card.dart';

// 1. Columns
List<DataColumn> buildHeaderColumns() {
  return const [
    DataColumn(
      label: Text("#", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Unit", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Tenant", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Status", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    // DataColumn(
    //   label: Text("Property", style: TextStyle(fontWeight: FontWeight.w200)),
    // ),
    DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

// 2. Data Rows
DataRow buildDataRow(Unit unit, int index, BuildContext context) {
  final Tenant? tenantInformation = unit.tenantId != null
      ? tenants.firstWhere((element) => element.tenantId == unit.tenantId)
      : null;

  return DataRow(
    onLongPress: () =>
        () => showDialog(
          context: context,
          builder: (context) => SingleUnitModal(unit: unit),
        ),

    cells: [
      // Index Column
      DataCell(
        Text(
          '$index',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // UnitName
      DataCell(
        Text(
          unit.unitName ?? unit.unitId,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Tenant
      DataCell(
        Text(
          tenantInformation?.tenantName ?? '',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Occupation Status
      DataCell(
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 80, maxHeight: 30),
          child: InformationBadge(
            text: unit.isOccupied == true ? 'Occupied' : 'Vacant',
            textColor: getOccupancyStatus(unit.isOccupied).textColor,
            badgeColor: getOccupancyStatus(unit.isOccupied).badgeColor,
          ),
        ),
      ),

      // Navigation Action Card
      DataCell(
        ViewChevronCard(
          onPressedCallBack: () => showDialog(
            context: context,
            builder: (context) => SingleUnitModal(unit: unit),
          ),
        ),
      ),
    ],
  );
}

class UnitsTable extends StatelessWidget {
  final List<Unit> units;
  const UnitsTable({super.key, required this.units});

  @override
  Widget build(BuildContext context) {
    return CustomDataTable(
      customDataColumns: [...buildHeaderColumns()],

      customDataRows: [
        ...units.asMap().entries.map((entry) {
          int index = entry.key;
          Unit unit = entry.value;
          return buildDataRow(unit, index + 1, context);
        }),
        // ...units.toList().asMap().entries.map((entry) {
        //   int index = entry.key; // 0, 1, 2, ...
        //   Unit unit = entry.value;
        //   return buildDataRow(unit, index + 1, context); // pass 1-based index
        // }),
      ],
    );
  }
}
