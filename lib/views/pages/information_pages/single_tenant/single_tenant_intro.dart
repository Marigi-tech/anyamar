import 'package:flutter/material.dart';
import 'package:test_app/data/constants.dart';
import 'package:test_app/data/constants/constants.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/widgets/buttons/card_button_widget.dart';

class SingleTenantIntro extends StatelessWidget {
  final Tenant tenant;
  final Unit unit;
  const SingleTenantIntro({
    super.key,
    required this.tenant,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            //Profile photo
            //TODO: Get actual photo
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColorsConstant.blueGreyColor,
              backgroundImage: AssetImage('assets/images/login.png'),
            ),
            SizedBox(width: 17),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Tenant Name
                Text(
                  tenant.tenantName,
                  style: CustomTextStyles.cardDescriptionStyle,
                ),
                SizedBox(height: 06),
                Row(
                  children: [
                    Text(
                      'Unit :  ',
                      style: CustomTextStyles.cardDescriptionStyle,
                    ),

                    //Unit Type
                    Text(
                      tenant.unitName ?? tenant.unitId,
                      style: CustomTextStyles.cardExtraDescriptionStyle
                          .copyWith(color: AppColorsConstant.lightGreenColor),
                    ),
                    Text(
                      ' Property : ${unit.propertyId}', //todo: get property name
                      style: CustomTextStyles.cardExtraDescriptionStyle
                          .copyWith(color: AppColorsConstant.lightGreenColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        //Rent details
        Align(
          alignment: Alignment.topRight,
          child: CardButtonWidget(
            buttonTitle:
                'Rent :  ${unit.rentCurrency}  ${unit.unitRent} / month',
          ),
        ),
      ],
    );
  }
}
