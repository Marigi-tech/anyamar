import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/providers/rent_provider.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/single_tenant/rent_history/rent_history_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/single_tenant/single_tenant_intro.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/single_tenant/tenant_information_widget.dart';
import 'package:anyamar/views/reusable_widgets/buttons/custom_back_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';

class SingleTenantPage extends ConsumerStatefulWidget {
  final Tenant tenant;
  const SingleTenantPage({super.key, required this.tenant});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SingleTenantPageState();
}

class _SingleTenantPageState extends ConsumerState<SingleTenantPage> {
  List<Property> myProperties = [];
  List<Unit> myUnits = [];
  Unit? tenantUnit;
  Property? tenantProperty;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ref
        .read(rentProvider(widget.tenant.tenantId!).notifier)
        .clearTenantRentHistory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    myUnits = ref.watch(userInformationProvider.select((state) => state.units));

    tenantUnit = myUnits
        .where((unit) => unit.unitId == widget.tenant.unitId)
        .single;
    Property tenantProperty = myProperties
        .where((property) => property.propertyId == tenantUnit?.propertyId)
        .single;

    final bool isMobile = Responsiveness.isMobile(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomBackButton(),
          SingleTenantIntro(tenant: widget.tenant, unit: tenantUnit),
          SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 20.0),
              child: isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TenantInformationWidget(
                          tenant: widget.tenant,
                          tenantProperty: tenantProperty,
                          tenantUnit: tenantUnit!,
                        ),
                        RentHistoryWidget(
                          tenant: widget.tenant,
                          tenantUnit: tenantUnit!,
                        ),
                        //     ],
                        //   ),
                        // )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TenantInformationWidget(
                            tenant: widget.tenant,
                            tenantProperty: tenantProperty,
                            tenantUnit: tenantUnit!,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: RentHistoryWidget(
                            tenant: widget.tenant,
                            tenantUnit: tenantUnit!,
                          ),
                        ),
                      ],
                    ),
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
