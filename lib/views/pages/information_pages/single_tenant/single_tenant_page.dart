import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/data_sets/properties.dart';
import 'package:anyamar/data/data_sets/rent_history.dart';
import 'package:anyamar/data/data_sets/units.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/data/models/rent_history_model.dart';
import 'package:anyamar/data/models/single_rental_entry_model.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/rent_history_widget.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/single_tenant_intro.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/tenant_information_widget.dart';

class SingleTenantPage extends StatelessWidget {
  final Tenant tenant;
  const SingleTenantPage({super.key, required this.tenant});

  @override
  Widget build(BuildContext context) {
    //todo : cater for tenants with multiple units eg air bnbs or big families
    Unit tenantUnit = tempunits.where((t) => t.unitId == tenant.unitId).single;
    Property tenantProperty = properties
        .where((p) => p.propertyId == tenant.propertyId)
        .single;
    RentHistory tenantRentHistory = rentHistory
        .where((r) => r.tenantId == tenant.tenantId)
        .single;
    List<SingleRentEntry> tenantRentEntries =
        tenantRentHistory.rentEntries ?? [];
    final bool isMobile = Responsiveness.isMobile(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: SingleTenantIntro(
                          tenant: tenant,
                          unit: tenantUnit,
                        ),
                      ),
                      TenantInformationWidget(
                        tenant: tenant,
                        tenantProperty: tenantProperty,
                        tenantUnit: tenantUnit,
                      ),
                      RentHistoryWidget(tenantRentEntries: tenantRentEntries),
                    ],
                  )
                : Row(
                    // direction: isMobile ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TenantInformationWidget(
                        tenant: tenant,
                        tenantProperty: tenantProperty,
                        tenantUnit: tenantUnit,
                      ),
                      RentHistoryWidget(
                        tenantRentEntries: tenantRentEntries,
                        tenant: tenant,
                        tenantUnit: tenantUnit,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
