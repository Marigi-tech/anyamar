import 'package:anyamar/data/models/date_format/date_format_model.dart';
import 'package:anyamar/forms/unit_form.dart';
import 'package:anyamar/forms/tenant_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/views/reusable_widgets/buttons/card_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyIntroCard extends ConsumerStatefulWidget {
  final Property property;
  const PropertyIntroCard({super.key, required this.property});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PropertyIntroCardState();
}

class _PropertyIntroCardState extends ConsumerState<PropertyIntroCard> {
  @override
  Widget build(BuildContext context) {
  
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
                      if (widget.property.lastUpdatedDate != null)
                        Text(
                          'Last Update :  ${formatPrettyDate(widget.property.lastUpdatedDate!)}',
                          style: CustomTextStyles.cardExtraDescriptionStyle,
                        ),
                    ],
                  ),
                  const Spacer(), // pushes buttons to the end
                  //No of tenants
                  Visibility(
                    visible: Responsiveness.isMobile(context) ? false : true,
                    child: CardButtonWidget(
                      buttonTitle: 'Add Tenant ',
                      buttonIcon: CupertinoIcons.add,
                      backgroundColor: AppColorsConstant.lightGreenColor,
                      fontColor: AppColorsConstant.whiteColor,
                      onPressedCallBack: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddTenant(currentProperty: widget.property),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  //No of units
                  Visibility(
                    visible: Responsiveness.isMobile(context) ? false : true,
                    child: CardButtonWidget(
                      buttonTitle: 'Add Unit ',
                      buttonIcon: CupertinoIcons.add,
                      fontColor: AppColorsConstant.whiteColor,
                      backgroundColor: AppColorsConstant.darkBlueColor,
                      onPressedCallBack: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              AddUnit(currentProperty: widget.property),
                        ),
                      ),
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
