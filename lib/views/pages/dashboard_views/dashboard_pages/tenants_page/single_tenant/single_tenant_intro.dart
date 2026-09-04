import 'package:flutter/material.dart';
import 'package:anyamar/commons/constants.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';

class SingleTenantIntro extends StatelessWidget {
  final Tenant tenant;
  final Unit? unit;
  const SingleTenantIntro({super.key, required this.tenant, this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColorsConstant.kBlue2, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //Profile photo
          //TO DO: Get actual photo
          CircleAvatar(
            radius: 28,

            backgroundColor: AppColorsConstant.blueGreyColor.withValues(
              alpha: 0.8,
            ),
            backgroundImage: AssetImage('assets/images/user.png'),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    tenant.tenantName,
                    style: CustomTextStyles.cardDescriptionStyle.copyWith(
                      fontStyle: FontStyle.normal,
                      color: AppColorsConstant.lightGreenColor,
                      fontSize: 16,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  //Unit Type
                  Text(
                    tenant.unitName ?? tenant.unitId,
                    style: CustomTextStyles.cardDescriptionStyle.copyWith(
                      color: AppColorsConstant.lightGreenColor,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        unit?.propertyName ?? '',
                        style: CustomTextStyles.cardDescriptionStyle.copyWith(
                          fontStyle: FontStyle.normal,
                          color: AppColorsConstant.lightGreenColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
