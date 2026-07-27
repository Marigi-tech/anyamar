import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/tenant_details.dart';

class TenantInformationWidget extends StatelessWidget {
  const TenantInformationWidget({
    super.key,
    required this.tenant,
    required this.tenantProperty,
    required this.tenantUnit,
  });

  final Tenant tenant;
  final Property tenantProperty;
  final Unit tenantUnit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tenant details',
              style: CustomTextStyles.cardDescriptionStyle.copyWith(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 20),

            TenantDetails(
              tenant: tenant,
              property: tenantProperty,
              unit: tenantUnit,
            ),
          ],
        ),
      ),
    );
  }
}
