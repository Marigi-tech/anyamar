import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/responsiveness/responsiveness.dart';
import 'package:anyamar/views/forms/property_forms/add_property.dart';
import 'package:anyamar/views/forms/tenant_forms/tenant_form.dart';
import 'package:anyamar/views/forms/unit_forms/unit_form.dart';
import 'package:anyamar/views/pages/information_pages/single_property/property_tabs/property_overview/occupancy_card.dart';
import 'package:anyamar/views/pages/information_pages/single_property/property_tabs/property_overview/property_management_info.dart';
import 'package:anyamar/views/reusable_widgets/buttons/card_button_widget.dart';
import 'package:anyamar/views/dashboard_widgets/tenant_information_card_widget.dart';
import 'package:anyamar/views/dashboard_widgets/unit_information_card_widget.dart';

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
                    fontColor: AppColorsConstant.whiteColor,

                    onPressedCallBack: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddProperty()),
                    ),
                  ),
                  SizedBox(height: 6),
                  CardButtonWidget(
                    buttonTitle: 'Add Tenant',
                    buttonIcon: CupertinoIcons.add,
                    backgroundColor: AppColorsConstant.lightGreenColor,
                    fontColor: AppColorsConstant.whiteColor,
                    onPressedCallBack: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddTenant()),
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
                    ).push(MaterialPageRoute(builder: (_) => AddUnit())),
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
