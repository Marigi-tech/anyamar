import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_widgets/tenant_information_card_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_widgets/unit_information_card_widget.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/tenant_forms/tenant_form.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/units/unit_forms/unit_form.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/single_property/property_tabs/property_overview/occupancy_card.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/single_property/property_tabs/property_overview/property_management_info.dart';
import 'package:anyamar/views/reusable_widgets/buttons/card_button_widget.dart';
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
              SizedBox(height: 20),
              CardButtonWidget(
                buttonTitle: 'Add Tenant',
                buttonIcon: CupertinoIcons.add,
                backgroundColor: AppColorsConstant.lightGreenColor,
                fontColor: AppColorsConstant.whiteColor,
                onPressedCallBack: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTenant(
                  currentProperty: property
                  )),
                ),
              ),
              SizedBox(height: 6),
              CardButtonWidget(
                buttonTitle: 'Add Unit',
                buttonIcon: CupertinoIcons.add,
                fontColor: AppColorsConstant.whiteColor,
                backgroundColor: AppColorsConstant.darkBlueColor,
                onPressedCallBack: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => AddUnit(currentProperty: property ))),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
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
