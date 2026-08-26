import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/single_property/property_tabs/property_overview/occupancy_rate_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OccupancyCard extends ConsumerWidget {
  final Property property;
  const OccupancyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Unit> myUnits = ref.watch(
      userInformationProvider.select((state) => state.units),
    );
    List<Tenant> myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );
    //Get Tenants
    List<Tenant> propertyTenants = myTenants
        .where((element) => element.propertyId == property.propertyId)
        .toList();
    //Get units
    List<Unit> propertyUnits = myUnits
        .where((element) => element.propertyId == property.propertyId)
        .toList();

    final occupancy = getOccupancyInfo(
      propertyTenants.length.toDouble(),
      propertyUnits.length.toDouble(),
    );
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 150, minHeight: 100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //todo: calculate actual occupanc rate
              //? no of occupied units / no of all units * 100%
              Text(
                'Occupancy Rate: ',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
              Text(
                occupancy.text,

                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 40,
                  color: occupancy.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
