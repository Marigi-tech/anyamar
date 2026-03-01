import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/data_sets/tenants.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/widgets/information_badges/information_badge_widget.dart';
import 'package:test_app/views/widgets/tables/view_chevron_card.dart';

TableRow buildUnitHeaderRow() {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Unit", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Tenant", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Status", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
    ],
  );
}

TableRow buildUnitDataRow(Unit unit, int index, BuildContext context) {
  final Tenant? tenantInformation = unit.tenantId != null
      ? tenants.firstWhere((element) => element.tenantId == unit.tenantId)
      : null;
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
          unit.unitName ?? unit.unitId,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          tenantInformation?.tenantName ?? '',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: InformationBadge(
          text: unit.isOccupied == true ? 'Occupied' : 'Vacant',
          textColor: getOccupancyStatus(unit.isOccupied).textColor,
          badgeColor: getOccupancyStatus(unit.isOccupied).badgeColor,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: ViewChevronCard(
          onPressedCallBack: () {},

          //todo: button logic
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
          5: FlexColumnWidth(4),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Header Row
          buildUnitHeaderRow(),

          ...units.toList().asMap().entries.map((entry) {
            int index = entry.key; // 0, 1, 2, ...
            Unit unit = entry.value;
            return buildUnitDataRow(
              unit,
              index + 1,
              context,
            ); // pass 1-based index
          }),
        ],
      ),
    );
  }
}
