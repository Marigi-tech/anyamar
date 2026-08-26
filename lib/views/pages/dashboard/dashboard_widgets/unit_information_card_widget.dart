import 'dart:developer';

import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/units_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitInformationCardWidget extends ConsumerWidget {
  final Property property;
  const UnitInformationCardWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Unit> myUnits = ref.watch(
      userInformationProvider.select((state) => state.units),
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
                    child: UnitsTable(units: propertyUnits),
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
