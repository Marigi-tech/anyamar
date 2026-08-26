import 'dart:developer';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/units/unit_forms/unit_form.dart';
import 'package:anyamar/views/pages/information_pages/single_unit/single_unit_modal.dart';
import 'package:anyamar/views/reusable_widgets/information_badges/information_badge_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/custom_data_table.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/view_chevron_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    DataColumn(
      label: Text("Update", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

// 2. Data Rows
DataRow buildDataRow(
  Unit unit,
  int index,
  BuildContext context,
  Tenant? tenantInformation,
  Property currentProperty,
) {
  log('The unit name : ${unit.unitName}');

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
          unit.unitName,
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
      // Update
      DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.pencil,
          onPressedCallBack: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  AddUnit(currentProperty: currentProperty, currentUnit: unit),
            ),
          ),
        ),
      ),
    ],
  );
}

class UnitsTable extends ConsumerWidget {
  final List<Unit> units;
  const UnitsTable({super.key, required this.units});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Tenant> myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );
    List<Property> myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );

    return CustomDataTable(
      customDataColumns: [...buildHeaderColumns()],

      customDataRows: [
        ...units.asMap().entries.map((entry) {
          int index = entry.key;
          Unit unit = entry.value;
          Property currentProperty = myProperties
              .where((prop) => prop.propertyId == unit.propertyId)
              .single;
          final Tenant? tenantInformation = unit.tenantId != null
              ? myTenants.singleWhere(
                  (element) => element.tenantId == unit.tenantId,
                )
              : null;
          return buildDataRow(
            unit,
            index + 1,
            context,
            tenantInformation,
            currentProperty,
          );
        }),
      ],
    );
  }
}
