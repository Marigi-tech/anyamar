import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/single_tenant/tenant_details.dart';

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
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(left: 15),
          //   child: Text(
          //     'Tenant details',
          //     style: CustomTextStyles.cardDescriptionStyle.copyWith(
          //       fontStyle: FontStyle.normal,
          //       fontWeight: FontWeight.w700,
          //       color: AppColorsConstant.darkBlueColor,
          //       fontSize: 15.0,
          //     ),
          //   ),
          // ),
          TenantDetails(
            tenant: tenant,
            property: tenantProperty,
            unit: tenantUnit,
          ),
        ],
      ),
    );
  }
}
