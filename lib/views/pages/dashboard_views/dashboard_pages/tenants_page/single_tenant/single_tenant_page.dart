import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/page_states/tenant_page_states.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/tenant_page_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/next_of_kin_information.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/single_page_quick_actions.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/tenant_information_column.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/tenant_rent_history.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/single_unit/widgets/unit_utilities.dart';

class SingleTenantPage extends ConsumerStatefulWidget {
  final Tenant tenant;
  final String introText;
  // final PageIntroInfo pageIntroInfo;
  const SingleTenantPage({
    super.key,
    required this.tenant,
    required this.introText,
    // required this.pageIntroInfo,
  });

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
    // ref
    //     .read(rentProvider(widget.tenant.tenantId!).notifier)
    //     .clearTenantRentHistory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(userInformationProvider);
    myProperties = appData.properties;
    myUnits = appData.units;
    Tenant tenant = appData.tenants
        .where((tenant) => tenant.tenantId == widget.tenant.tenantId)
        .single;

    tenantUnit = myUnits
        .where((unit) => unit.unitId == widget.tenant.unitId)
        .single;

    return DashboardPageStructure(
      introText: widget.introText,
      pageTitle: tenant.tenantName,
      supplementaryText:
          ' Phone : ${tenant.tenantPhoneNumber} | '
          ' Email : ${tenant.tenantEmail} | '
          ' National Id / Passport Number: ${tenant.nationalId ?? 'N/A'} ',
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Update Tenant',
          buttonIcon: Icon(CupertinoIcons.pencil),
          onButtonPressedCallBack: () {
            ref
                .read(workspaceProvider.notifier)
                .openForm(
                  UpdateTenantState(
                    introText: widget.introText,
                    tenant: tenant,
                  ),
                );
          },
        ),
      ],
      introButton: IntroButtonWidget(),
      scrollableDashboardWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Responsiveness.isMobile(context)
              ? Column(
                  children: [
                    // --------------------------------------------
                    // Data Row
                    // --------------------------------------------
                    SingleTenantPageSummaryCards(tenant: tenant),
                    SizedBox(height: 30.0),
                    TenantInformationColumn(tenant: tenant),
                    SizedBox(height: 20.0),
                    //Rent History
                    TenantRentHistory(
                      tenant: tenant,
                      introText: '${widget.introText} / rent history ',
                    ),
                    //todo:Recent Activity
                    // SinglePageRecentActivityWidget(tenant: tenant),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // --------------------------------------------
                          // Data Row
                          // --------------------------------------------
                          //Cards
                          SingleTenantPageSummaryCards(tenant: tenant),
                          SizedBox(height: 30.0),
                          //Tenant Information
                          TenantInformationColumn(tenant: tenant),
                          SizedBox(height: 20.0),
                          //Rent History
                          TenantRentHistory(
                            tenant: tenant,
                            introText: '${widget.introText} / rent history',
                          ),
                          SizedBox(height: 20.0),
                          UlitiesChargeWidget(rentObject: tenant.unitRent),
                        ],
                      ),
                    ),
                    SizedBox(width: 25.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Quick Actions
                          SinglePageQuickActionsWidget(
                            tenant: tenant,
                            introText: widget.introText,
                          ),
                          SizedBox(height: 20.0),
                          //Next of Kin Information
                          NextOfKinInformationColumn(person: tenant.nextOfKin),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
