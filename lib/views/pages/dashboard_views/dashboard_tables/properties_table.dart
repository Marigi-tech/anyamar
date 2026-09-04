import 'package:anyamar/commons/exports.dart';



// 1. Columns
List<DataColumn> buildHeaderColumns() {
  return const [
    DataColumn(
      label: Text("#", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Property", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Location", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Managed By", style: TextStyle(fontWeight: FontWeight.w200)),
    ),
    DataColumn(
      label: Text("Units", style: TextStyle(fontWeight: FontWeight.w200)),
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
  Property property,
  int index,
  BuildContext context,
  List<Unit>? units,
  WidgetRef ref,
) {
  Future<bool?> showDeleteConfirmationDialog(
    BuildContext context,
    Property property,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertModal(
          dialogTitle: 'Property',
          isDeleteModal: true,
          recordId: property.propertyName,
        );
      },
    );
  }

  return DataRow(
    onLongPress: () => Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SinglePropertyPage(property: property)),
    ),
    cells: [
      // Index Column
      DataCell(
        Text(
          '$index',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Property Name
      DataCell(
        Text(
          property.propertyName,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Property Location
      DataCell(
        Text(
          property.propertyLocation,
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Property Manager
      DataCell(
        Text(
          property.propertyManager?.personName ?? '',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Filtered Units Count
      DataCell(
        Text(
          '${units?.where((element) => element.propertyId == property.propertyId).length}',
          style: TextStyle(color: AppColorsConstant.blueGreyColor),
        ),
      ),
      // Navigation Action Card
      DataCell(
        ViewChevronCard(
          onPressedCallBack: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SinglePropertyPage(property: property),
              ),
            );
          },
        ),
      ),
      // Update
      DataCell(
        ViewChevronCard(
          iconData: CupertinoIcons.pencil,
          onPressedCallBack: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddProperty(currentProperty: property),
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
            final shouldDelete = await showDeleteConfirmationDialog(
              context,
              property,
            );
            // User pressed Cancel or dismissed the dialog
            if (shouldDelete != true) {
              return;
            }

            LazyLoader lazyLoader = LazyLoader(context: context);
            lazyLoader.showLoader();
            final db = DbPropertyService();
            try {
              final isSuccessful = await db.deletePropertyRecord(property);
              if (isSuccessful) {
                await ref
                    .read(userInformationProvider.notifier)
                    .removeProperty(property.propertyId);
                displaySnackBar(
                  context,
                  'Property deleted succesfully',
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

