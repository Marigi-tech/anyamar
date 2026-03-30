import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/data_sets/properties.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/single_tenant_page.dart';
import 'package:test_app/views/tables/view_chevron_card.dart';

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
      !isUnitTenant
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              child: Text(
                'Property ',
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
            )
          : SizedBox(),

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
  String? propertyName,
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
      propertyName != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: Text(
                propertyName,
                style: TextStyle(color: AppColorsConstant.blueGreyColor),
              ),
            )
          : SizedBox(),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: ViewChevronCard(
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
          4: FlexColumnWidth(2),
          5: FlexColumnWidth(1),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,

        children: [
          // Header Row
          buildTenantHeaderRow(isUnitTenant),

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
      ),
    );
  }
}
