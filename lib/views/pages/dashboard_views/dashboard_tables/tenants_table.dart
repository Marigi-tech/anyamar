import 'package:anyamar/commons/exports.dart';

List<DataColumn> buildTenantHeaderRows(bool isUnitTenant, bool isPropertyNull) {
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
    // const DataColumn(
    //   label: Text("Email", style: TextStyle(fontWeight: FontWeight.w200)),
    // ),
    // const DataColumn(
    //   label: Text("National ID", style: TextStyle(fontWeight: FontWeight.w200)),
    if (!isUnitTenant)
      const DataColumn(
        label: Text("Unit ", style: TextStyle(fontWeight: FontWeight.w200)),
      ),

    // Collection if cleanly removes the column entirely when isUnitTenant is true
    if (!isPropertyNull )
      const DataColumn(
        label: Text('Property ', style: TextStyle(fontWeight: FontWeight.w200)),
      ),
    const DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    const DataColumn(
      label: Text("Update", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Delete", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
  ];
}

DataRow buildTenantDataRow(
  int index,
  Tenant tenant,
  BuildContext context,
  String? propertyName,
  WidgetRef ref,
  bool? isUnitTenant,
) {
  // Common text style definition to reduce repetition
  final cellStyle = TextStyle(color: AppColorsConstant.blueGreyColor);
  Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertModal(
          dialogTitle: 'Tenants',
          isDeleteModal: true,
          recordId: tenant.tenantName,
        );
      },
    );
  }

  List<Unit> myUnits = ref.watch(
    userInformationProvider.select((state) => state.units),
  );
  //Fetch Unit
  Unit fetchUnit = myUnits.where((unit) => unit.unitId == tenant.unitId).single;

  //Fetch Property
  List<Property> myProperties = ref.watch(
    userInformationProvider.select((state) => state.properties),
  );
  //Fetch Unit
  Property fetchProperty = myProperties
      .where((property) => property.propertyId == tenant.propertyId)
      .single;

  return DataRow(
    onLongPress: () => Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => SingleTenantPage(tenant: tenant))),
    cells: [
      DataCell(Text('  $index  ', style: cellStyle)),
      DataCell(Text(tenant.tenantName, style: cellStyle)),
      DataCell(Text(tenant.tenantPhoneNumber ?? '', style: cellStyle)),
      // DataCell(Text(tenant.tenantEmail ?? 'N/A', style: cellStyle)),
      // DataCell(Text(tenant.tenantNationalId ?? 'N/A', style: cellStyle)),
      if (isUnitTenant != true)
        DataCell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SingleUnitPage(unit: fetchUnit)),
          ),
          Text(tenant.unitName ?? tenant.unitId, style: cellStyle),
        ),

      // Clean conditional insertion matching the header count exactly
      if (propertyName != null)
        DataCell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SinglePropertyPage(property: fetchProperty),
            ),
          ),
          Text(propertyName, style: cellStyle),
        ),
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
      DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.pencil,
          onPressedCallBack: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddTenant(currentTenant: tenant),
              ),
            );
          },
        ),
      ),
      DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.trash,
          iconColor: AppColorsConstant.redColor,
          onPressedCallBack: () async {
            final shouldDelete = await showDeleteConfirmationDialog(context);
            // User pressed Cancel or dismissed the dialog
            if (shouldDelete != true) {
              return;
            }

            LazyLoader lazyLoader = LazyLoader(context: context);
            lazyLoader.showLoader();
            final db = DbTenantService();
            try {
              final isSuccessful = await db.deleteTenantRecord(tenant);
              if (isSuccessful) {
                await ref
                    .read(userInformationProvider.notifier)
                    .removeTenant(tenant.tenantId);
                displaySnackBar(
                  context,
                  'Tenant deleted succesfully',
                  AppColorsConstant.greenColor,
                );
              }
              //
            } catch (e) {
              displaySnackBar(
                context,
                'Error $e occured when deleting the property',
                AppColorsConstant.redColor,
              );
            } finally {
              lazyLoader.hideLoader();
            }
          },
        ),
      ),
    ],
  );
}
