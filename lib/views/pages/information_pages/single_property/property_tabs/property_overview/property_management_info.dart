import 'package:flutter/cupertino.dart';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/property_model.dart';

class PropertyManagementInfo extends StatelessWidget {
  final Property property;
  const PropertyManagementInfo({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    //todo: get actual caretaker information
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400, minHeight: 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Caretaker Image
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColorsConstant.blueGreyColor,
                backgroundImage: AssetImage('assets/images/login.png'),
              ),

              const SizedBox(height: 12),

              // Name
              Text(
                property.propertyManager,
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
                    '0799509119',
                    style: CustomTextStyles.cardDescriptionStyle,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              //Agency
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.home, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    'Agency:  Lyon\'s Agency',
                    style: CustomTextStyles.cardExtraDescriptionStyle,
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
