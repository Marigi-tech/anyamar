import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/data_sets/properties.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/single_tenant_page.dart';
import 'package:anyamar/views/tables/custom_data_table.dart';
import 'package:anyamar/views/tables/view_chevron_card.dart';

List<DataColumn> buildTenantHeaderRows(bool isUnitTenant) {
  return [
    const DataColumn(
      label: Text("", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Full Name", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text(
        "Phone Number",
        style: TextStyle(fontWeight: FontWeight.w200),
      ),
    ),
    const DataColumn(
      label: Text("Email", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("National ID", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Unit ", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    // Collection if cleanly removes the column entirely when isUnitTenant is true
    if (!isUnitTenant)
      const DataColumn(
        label: Text('Property ', style: TextStyle(fontWeight: FontWeight.w200)),
      ),
    const DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

DataRow buildTenantDataRow(
  int index,
  Tenant tenant,
  BuildContext context,
  String? propertyName,
) {
  // Common text style definition to reduce repetition
  final cellStyle = TextStyle(color: AppColorsConstant.blueGreyColor);

  return DataRow(
    onLongPress: () => Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => SingleTenantPage(tenant: tenant))),
    cells: [
      DataCell(Text('  $index  ', style: cellStyle)),
      DataCell(Text(tenant.tenantName, style: cellStyle)),
      DataCell(Text(tenant.tenantPhoneNumber, style: cellStyle)),
      DataCell(Text(tenant.tenantEmail ?? 'N/A', style: cellStyle)),
      DataCell(Text(tenant.tenantNationalId ?? 'N/A', style: cellStyle)),
      DataCell(Text(tenant.unitName ?? tenant.unitId, style: cellStyle)),

      // Clean conditional insertion matching the header count exactly
      if (propertyName != null) DataCell(Text(propertyName, style: cellStyle)),
      DataCell(
        ViewChevronCard(
          onPressedCallBack: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SingleTenantPage(tenant: tenant),
              ),
            );
          },
        ),
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
    return CustomDataTable(
      customDataColumns: [...buildTenantHeaderRows(isUnitTenant)],
      customDataRows: [
        ...isUnitTenant
            ? propertyTenants.toList().asMap().entries.map((entry) {
                int index = entry.key;
                Tenant tenant = entry.value;
                return buildTenantDataRow(
                  index + 1,
                  tenant,
                  context,
                  null,
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