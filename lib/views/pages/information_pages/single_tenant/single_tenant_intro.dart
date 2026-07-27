import 'package:flutter/material.dart';
import 'package:anyamar/constants/constants.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/data/models/unit_model.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Profile photo
        //TODO: Get actual photo
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColorsConstant.blueGreyColor,
          backgroundImage: AssetImage('assets/images/login.png'),
        ),
        SizedBox(width: 17),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Tenant Name
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tenant : ',
                  style: CustomTextStyles.cardDescriptionStyle.copyWith(
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  tenant.tenantName,
                  style: CustomTextStyles.cardDescriptionStyle.copyWith(
                    fontStyle: FontStyle.normal,
                    color: AppColorsConstant.lightGreenColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 06),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unit :  ',
                  style: CustomTextStyles.cardDescriptionStyle.copyWith(
                    fontStyle: FontStyle.normal,
                  ),
                ),

                //Unit Type
                Text(
                  tenant.unitName ?? tenant.unitId,
                  style: CustomTextStyles.cardDescriptionStyle.copyWith(
                    color: AppColorsConstant.lightGreenColor,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(width: 05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Property : ',
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      unit.propertyName ?? unit.propertyId,
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        fontStyle: FontStyle.normal,
                        color: AppColorsConstant.lightGreenColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
