import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/providers/rent_provider.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/rent_history/rent_history_widget.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/single_tenant_intro.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/tenant_information_widget.dart';
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
                          tenant: widget.tenant,
                          unit: tenantUnit!,
                        ),
                      ),
                      TenantInformationWidget(
                        tenant: widget.tenant,
                        tenantProperty: tenantProperty,
                        tenantUnit: tenantUnit!,
                      ),
                      RentHistoryWidget(
                        tenant: widget.tenant,
                        tenantUnit: tenantUnit!,
                      ),
                    ],
                  )
                : Row(
                    // direction: isMobile ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
