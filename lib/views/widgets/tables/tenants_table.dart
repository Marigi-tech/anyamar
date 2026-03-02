import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/data_sets/properties.dart';
import 'package:test_app/data/data_sets/units.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/widgets/tables/table_widget.dart';
import 'package:test_app/views/widgets/tables/view_chevron_card.dart';

TableRow buildTenantHeaderRow(bool isUnitTenant) {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Full Name", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text(
          "Phone Number",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("Unit ", style: TextStyle(fontWeight: FontWeight.w200)),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text(
          isUnitTenant ? 'Unit Type' : 'Property ',
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
    ],
  );
}

TableRow buildTenantDataRow(
  int index,
  Tenant tenant,
  BuildContext context,
  String? propertyNameOrUnitType,
) {
  return TableRow(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          '  $index  ',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          tenant.tenantName,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          tenant.tenantPhoneNumber,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          tenant.unitName ?? tenant.unitId,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Text(
          propertyNameOrUnitType ?? '',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: ViewChevronCard(onPressedCallBack: () {}),
      ),
    ],
  );
}

class TenantsTable extends StatelessWidget {
  // final Property? property;
  final List<Tenant> propertyTenants;
  final bool isUnitTenant;
  const TenantsTable({
    super.key,
    required this.propertyTenants,
    required this.isUnitTenant,
  });

  @override
  Widget build(BuildContext context) {
    return TableWidget(
      cardHeaderWidget: SizedBox(),
      tableColumnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(1),
      },

      tableChildren: [
        // Header Row
        buildTenantHeaderRow(isUnitTenant),

        ...isUnitTenant
            ? propertyTenants.toList().asMap().entries.map((entry) {
                int index = entry.key;
                Tenant tenant = entry.value;
                Unit propertyUnit = units
                    .where((u) => u.tenantId == tenant.tenantId)
                    .single;
                return buildTenantDataRow(
                  index + 1,
                  tenant,
                  context,
                  propertyUnit.unitType.label,
                ); // pass 1-based index
              })
            : propertyTenants.toList().asMap().entries.map((entry) {
                int index = entry.key;
                Tenant tenant = entry.value;
                String propertyName = properties
                    .firstWhere(
                      (element) => element.propertyId == tenant.propertyId,
                    )
                    .propertyName;
                return buildTenantDataRow(
                  index + 1,
                  tenant,
                  context,
                  propertyName,
                );
              }),
      ],
    );
  }
}
