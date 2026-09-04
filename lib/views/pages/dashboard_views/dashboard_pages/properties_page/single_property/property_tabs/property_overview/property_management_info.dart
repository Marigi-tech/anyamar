import 'package:flutter/cupertino.dart';
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/properties/property_model.dart';

class PropertyManagementInfo extends StatelessWidget {
  final Property property;
  const PropertyManagementInfo({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400, minHeight: 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Caretaker Image
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColorsConstant.blueGreyColor.withValues(
                  alpha: 0.8,
                ),
                backgroundImage: AssetImage('assets/images/user.png'),
              ),

              const SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: Text(
                  property.propertyManager?.isAgency == true
                      ? 'Agency'
                      : 'Manager',
                  style: TextStyle(
                    color: AppColorsConstant.blueGreyColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Name
              Text(
                'Name : ${property.propertyManager?.personName ?? ''}',
                style: CustomTextStyles.cardDescriptionStyle,
              ),
              const SizedBox(height: 6),
              // Phone
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.phone, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    'Phone : ${property.propertyManager?.personPhone ?? ''}',
                    style: CustomTextStyles.cardDescriptionStyle,
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  const Icon(CupertinoIcons.envelope, size: 14),
                  const SizedBox(width: 6),
                  FittedBox(
                    child: Text(
                      'Email:  ${property.propertyManager?.personEmail ?? ''}',
                      style: CustomTextStyles.cardExtraDescriptionStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
