import 'package:anyamar/commons/exports.dart';

// 1. Columns
List<DataColumn> buildHeaderColumns(bool? isUnitPage) {
  return [
    DataColumn(
      label: Text("#", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Unit", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    if (isUnitPage == true)
      DataColumn(
        label: Text("Property", style: TextStyle(fontWeight: FontWeight.w200)),
      ),
    DataColumn(
      label: Text("Tenant", style: TextStyle(fontWeight: FontWeight.w200)),
    ),

    DataColumn(
      label: Text("View", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Update", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Delete", style: TextStyle(fontWeight: FontWeight.w200)),
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
  bool? isUnitPage,
  WidgetRef ref,
) {
  log('The unit name : ${unit.unitName}');
    Future<bool?> showDeleteConfirmationDialog(
    BuildContext context,
   
  ) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertModal(
          dialogTitle: 'Units',
          isDeleteModal: true,
          recordId: unit.unitName,
        );
      },
    );
  }

  return DataRow(
    onLongPress: () => Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => SingleUnitPage(unit: unit))),

    // onLongPress: () =>
    //     () => showDialog(
    //       context: context,
    //       builder: (context) => SingleUnitModal(unit: unit),
    //     ),
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
      if (isUnitPage == true)
        DataCell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SinglePropertyPage(property: currentProperty),
            ),
          ),
          Text(
            currentProperty.propertyName,
            style: TextStyle(color: AppColorsConstant.blueGreyColor),
          ),
        ),
      // Tenant
      if (unit.isOccupied)
        DataCell(
          Text(
            tenantInformation?.tenantName ?? '',
            style: TextStyle(color: AppColorsConstant.blueGreyColor),
          ),
        )
      else
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
          onPressedCallBack: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => SingleUnitPage(unit: unit))),
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
       DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.trash,
          iconColor: AppColorsConstant.redColor,
          onPressedCallBack: () async {
            final shouldDelete = await showDeleteConfirmationDialog(
              context,
              
            );
            // User pressed Cancel or dismissed the dialog
            if (shouldDelete != true) {
              return;
            }

            LazyLoader lazyLoader = LazyLoader(context: context);
            lazyLoader.showLoader();
            final db = DbUnitsService();
            try {
              final isSuccessful = await db.deleteUnitRecord(unit);
              if (isSuccessful) {
                await ref
                    .read(userInformationProvider.notifier)
                    .removeUnit(unit.unitId);
                displaySnackBar(
                  context,
                  'Unit deleted succesfully',
                  AppColorsConstant.greenColor,
                );
              }
              //
            } catch (e) {
              displaySnackBar(
                context,
                'Error $e occured when deleting the unit',
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

