import 'package:flutter/cupertino.dart';

import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/models/date_format_model.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/data/data_sets/tenants.dart';
import 'package:test_app/data/data_sets/units.dart' show units;
import 'package:test_app/views/reusable_widgets/buttons/card_button_widget.dart';

class PropertyIntroCard extends StatefulWidget {
  final Property property;
  const PropertyIntroCard({super.key, required this.property});

  @override
  State<PropertyIntroCard> createState() => _PropertyIntroCardState();
}

class _PropertyIntroCardState extends State<PropertyIntroCard> {
  @override
  Widget build(BuildContext context) {
    List<Tenant> propertyTenants = tenants
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    List<Unit> propertyUnits = units
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Property Image
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      // borderRadius: BorderRadius.circular(25),
                      //TODO: GET ACTUAL IMAGE
                      child: Image.asset(
                        'assets/images/bg.jpg',
                        fit: BoxFit.contain,
                        width: 80,
                        height: 60,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  // Property Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Property name
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          widget.property.propertyName,
                          style: CustomTextStyles.cardTitleStyle,
                        ),
                      ),
                      // Property Location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(CupertinoIcons.location, size: 15),
                          SizedBox(width: 4),
                          Text(
                            widget.property.propertyLocation,
                            style: CustomTextStyles.cardDescriptionStyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      //Last updated
                      //TODO: Display actual date
                      Text(
                        'Last Update :  ${formatPrettyDate(DateTime.now())}',
                        style: CustomTextStyles.cardExtraDescriptionStyle,
                      ),
                    ],
                  ),
                  const Spacer(), // pushes buttons to the end
                  Visibility(
                    visible: Responsiveness.isMobile(context) ? false : true,
                    child: CardButtonWidget(
                      buttonTitle: 'Units : ${propertyUnits.length}',
                      buttonIcon: CupertinoIcons.building_2_fill,
                    ),
                  ),
                  SizedBox(width: 5),
                  //? No of tenants
                  Visibility(
                    visible: Responsiveness.isMobile(context) ? false : true,
                    child: CardButtonWidget(
                      buttonTitle: 'Tenants :${propertyTenants.length}',
                      buttonIcon: CupertinoIcons.person_2_alt,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
