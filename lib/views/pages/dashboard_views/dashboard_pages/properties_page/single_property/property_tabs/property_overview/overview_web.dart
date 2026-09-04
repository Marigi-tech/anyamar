import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/tenant_information_card_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/unit_information_card_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_overview/occupancy_card.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/single_property/property_tabs/property_overview/property_management_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OverviewWeb extends ConsumerWidget {
  final Property property;
  const OverviewWeb({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              OccupancyCard(property: property),
              SizedBox(height: 5),
              if (property.propertyManager != null)
                PropertyManagementInfo(property: property),
        
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            // Mobile/Tablet Stacked Layout
            children: [
              UnitInformationCardWidget(property: property),
              SizedBox(height: 10), // Add spacing between stacked cards
              TenantInformationCardWidget(
                isUnitTenant: true,
                property: property,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
