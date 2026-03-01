import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/responsiveness/responsiveness.dart';
import 'package:test_app/views/pages/information_pages/single_property/property_tabs/property_overview/occupancy_card.dart';
import 'package:test_app/views/pages/information_pages/single_property/property_tabs/property_overview/property_management_info.dart';
import 'package:test_app/views/widgets/buttons/card_button_widget.dart';
import 'package:test_app/views/widgets/dashboard_widgets/tenant_information_card_widget.dart';
import 'package:test_app/views/widgets/dashboard_widgets/unit_information_card_widget.dart';

class PropertyOverview extends StatefulWidget {
  final Property property;
  const PropertyOverview({super.key, required this.property});

  @override
  State<PropertyOverview> createState() => _PropertyOverviewState();
}

class _PropertyOverviewState extends State<PropertyOverview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Caretaker and Agency
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Occupancy %
              OccupancyCard(property: widget.property),

              SizedBox(width: 5),
              //Property manager Info Card
              PropertyManagementInfo(property: widget.property),
              SizedBox(width: 5),
              //Add Buttons
              Column(
                children: [
                  CardButtonWidget(
                    buttonTitle: 'Add Property',
                    buttonIcon: CupertinoIcons.add,
                    backgroundColor: AppColorsConstant.darkYellowColor,
                  ),
                  SizedBox(height: 6),
                  CardButtonWidget(
                    buttonTitle: 'Add Tenant',
                    buttonIcon: CupertinoIcons.add,
                    backgroundColor: AppColorsConstant.lightGreenColor,
                  ),
                  SizedBox(height: 6),
                  CardButtonWidget(
                    buttonTitle: 'Add Unit',
                    buttonIcon: CupertinoIcons.add,
                    backgroundColor: AppColorsConstant.darkBlueColor,
                  ),
                ],
              ),
            ],
          ),
        ),

        Responsiveness.isDesktop(context)
            ? Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: UnitInformationCardWidget(property: widget.property),
                  ),

                  Expanded(
                    child: TenantInformationCardWidget(
                      isUnitTenant: true,
                      property: widget.property,
                    ),
                  ),
                ],
              )
            : Column(
                // Mobile/Tablet Stacked Layout
                children: [
                  UnitInformationCardWidget(property: widget.property),
                  SizedBox(height: 10), // Add spacing between stacked cards
                  TenantInformationCardWidget(
                    isUnitTenant: true,
                    property: widget.property,
                  ),
                ],
              ),
      ],
    );
  }
}
