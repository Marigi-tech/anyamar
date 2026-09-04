import 'dart:developer';

import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/custom_data_table.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/units_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitInformationCardWidget extends ConsumerWidget {
  final Property property;
  const UnitInformationCardWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Unit> myUnits = ref.watch(
      userInformationProvider.select((state) => state.units),
    );
     List<Tenant> myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );
    List<Unit> propertyUnits = myUnits
        .where((element) => element.propertyId == property.propertyId)
        .toList();
    log('This are my units : ${propertyUnits.toString()}');
    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return Container(
          width: Responsiveness.isDesktop(context)
              ? getSizeFromContext(context).width * .60
              : double.infinity,
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                //Enter card title here
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Units',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                //Divider
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(thickness: 0.18, height: 10.0),
                ),
                SizedBox(height: 10.0),
                // Scrollable Table Section
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: CustomDataTable(
            customDataColumns: [...buildHeaderColumns(true)],

            customDataRows: [
              ...propertyUnits.asMap().entries.map((entry) {
                int index = entry.key;
                Unit unit = entry.value;
                Property currentProperty = property;
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
                  true,
                  ref,
                );
              }),
            ],
          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
