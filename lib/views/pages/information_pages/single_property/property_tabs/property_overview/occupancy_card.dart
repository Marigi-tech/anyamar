import 'package:flutter/material.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/data/data_sets/tenants.dart';
import 'package:test_app/data/data_sets/units.dart';
import 'package:test_app/views/pages/information_pages/single_property/property_tabs/property_overview/occupancy_rate_view.dart';

class OccupancyCard extends StatelessWidget {
  final Property property;
  const OccupancyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    List<Tenant> propertyTenants = tenants
        .where((element) => element.propertyId == property.propertyId)
        .toList();
    List<Unit> propertyUnits = units
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
