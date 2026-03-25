import 'package:test_app/data/constants.dart';
import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/data_sets/properties.dart';
import 'package:test_app/data/data_sets/rent_history.dart';
import 'package:test_app/data/data_sets/units.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/rent_history_model.dart';
import 'package:test_app/data/models/single_rental_entry_model.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/lease_details.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/single_tenant_intro.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/tenant_details.dart';
import 'package:test_app/views/widgets/tables/rent_history.dart';

class SingleTenantPage extends StatelessWidget {
  final Tenant tenant;
  const SingleTenantPage({super.key, required this.tenant});

  @override
  Widget build(BuildContext context) {
    //todo : cater for tenants with multiple units eg air bnbs or big families
    Unit tenantUnit = units.where((t) => t.unitId == tenant.unitId).single;
    Property tenantProperty = properties
        .where((p) => p.propertyId == tenant.propertyId)
        .single;
    RentHistory tenantRentHistory = rentHistory
        .where((r) => r.tenantId == tenant.tenantId)
        .single;
    List<SingleRentEntry> tenantRentEntries =
        tenantRentHistory.rentEntries ?? [];
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
            minHeight: double.infinity,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tenant photo and rent information
              SingleTenantIntro(tenant: tenant, unit: tenantUnit),
              SizedBox(height: 30),
              SizedBox(
                height: getSizeFromContext(context).height * .70,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      //todo: make responsive
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //? Personal details
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Personal details',
                                  style: CustomTextStyles.cardDescriptionStyle
                                      .copyWith(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                SizedBox(height: 10),

                                TenantDetails(
                                  tenant: tenant,
                                  property: tenantProperty,
                                  unit: tenantUnit,
                                ),
                              ],
                            ),
                          ),

                          //Lease details
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Column(
                                children: [
                                  Text(
                                    'Lease details',
                                    style: CustomTextStyles.cardDescriptionStyle
                                        .copyWith(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  SizedBox(height: 10),
                                  LeaseDetails(
                                    tenant: tenant,
                                    property: tenantProperty,
                                    unit: tenantUnit,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Payment History',
                        style: CustomTextStyles.cardDescriptionStyle.copyWith(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 30,
                                  horizontal: 30.0,
                                ),
                                child: RentHistoryTable(
                                  rentEntries: tenantRentEntries,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
