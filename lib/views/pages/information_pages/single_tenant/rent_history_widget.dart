//Rent History Widget
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/single_rental_entry_model.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/single_tenant_intro.dart';
import 'package:anyamar/views/tables/rent_history.dart';

class RentHistoryWidget extends StatelessWidget {
  const RentHistoryWidget({
    super.key,
    required this.tenantRentEntries,
    this.tenant,
    this.tenantUnit,
  });
  final Tenant? tenant;
  final Unit? tenantUnit;

  final List<SingleRentEntry> tenantRentEntries;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsiveness.isMobile(context);
    return Expanded(
      flex: isMobile ? 1 : 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tenant != null && tenantUnit != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: SingleTenantIntro(tenant: tenant!, unit: tenantUnit!),
            ),
          SizedBox(height: 20),
          Text(
            'Rent payment history',
            style: CustomTextStyles.cardDescriptionStyle.copyWith(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
              fontSize: 15.0,
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
              child: RentHistoryTable(rentEntries: tenantRentEntries),
            ),
          ),
        ],
      ),
    );
  }
}
