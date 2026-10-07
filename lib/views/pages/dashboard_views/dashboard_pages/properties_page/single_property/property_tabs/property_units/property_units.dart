import 'package:anyamar/commons/exports.dart';

class PropertyUnits extends ConsumerStatefulWidget {
  final Property property;
  const PropertyUnits({super.key, required this.property});

  @override
  ConsumerState<PropertyUnits> createState() => _PropertyUnitsState();
}

class _PropertyUnitsState extends ConsumerState<PropertyUnits> {
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(appDataProvider);
    final propertyUnits = appData.units
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();

    final columns = [
      TableColumnConfig(title: '#', flex: 0.3),
      TableColumnConfig(title: 'Unit Name/ Code', flex: 1.1),
      TableColumnConfig(title: 'Unit type', flex: 1.1),
      TableColumnConfig(title: 'Rent', flex: 1.1),
      TableColumnConfig(title: 'Status', flex: 1.0),
      TableColumnConfig(title: 'Actions', flex: 0.4),
    ];
    final rows = propertyUnits.map((unit) {
      var index = propertyUnits.indexOf(unit) + 1;
      return [
        ItemCell(value: '${index++}'),
        ItemCell(value: unit.unitName),
        ItemCell(value: '${unit.unitType?.label}'),
        ItemCell(
          value: formatMoneyWithCurrency(
            unit.unitRent?.rentAmount as num,
            unit.unitRent?.rentCurrency,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: UnitVacancyBadge(isOccupied: unit.isOccupied),
        ),

        IconButton(
          icon: Icon(Icons.more_vert, size: 18, color: Color(0xFF7D8794)),
          onPressed: () {},
        ),
      ];
    }).toList();

    return SearchlessTableWidget(columns: columns, rows: rows);
  }
}
