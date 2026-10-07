import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/tenant_page/tenant_page_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/tenant_page_summary_cards.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/quick_tenant_actions.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/widgets/rental_month_widget.dart';

// ============================================================
// PAGE STATES
// ============================================================
sealed class TenantsPageState {
  const TenantsPageState();
}

class TenantsTablePageState extends TenantsPageState {
  const TenantsTablePageState();
}

class AddTenantPageState extends TenantsPageState {
  const AddTenantPageState();
}

class ViewTenantPageState extends TenantsPageState {
  final Tenant tenant;
  const ViewTenantPageState({required this.tenant});
}

class UpdateTenantPageState extends TenantsPageState {
  final Tenant tenant;

  const UpdateTenantPageState({required this.tenant});
}

class AddRentEntryState extends TenantsPageState {
  final Tenant tenant;
  const AddRentEntryState({required this.tenant});
}

class ViewRentalMonthState extends TenantsPageState {
  final RentalMonth rentalMonth;
  final Tenant tenant;
  const ViewRentalMonthState({required this.rentalMonth, required this.tenant});
}
// ============================================================
// BASE TENANTS PAGE
// ============================================================

class TenantsPage extends ConsumerWidget {
  const TenantsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenantsPageState = ref.watch(tenantPageProvider);

    return switch (tenantsPageState) {
      TenantsTablePageState() => DashboardPageStructure(
        introText: 'Tenants',
        pageTitle: 'All Tenants',
        supplementaryText: 'Manage all your tenants in one area',
        introRowWidgets: [
          ElevatedButtonWidget(
            buttonTitle: 'Add Tenant',
            buttonIcon: Icon(Icons.add),
            onButtonPressedCallBack: () {
              ref.read(tenantPageProvider.notifier).showAddTenantForm();
            },
          ),
        ],
        scrollableDashboardWidget: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TenantPageSummaryCards(),
                  SizedBox(height: 15.0),
                  TenantsTable(),
                ],
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuickActionsTenantWidget(),
                  SizedBox(height: 20.0),
                  DashboardCardWidget(
                    cardTitle: 'Recent Activity',
                    child: Column(children: []),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      AddTenantPageState() => DashboardPageStructure(
        introText: 'Tenants',
        introButton: IntroButtonWidget(
          buttonText: 'Back',
          onPressedCallBack: () {
            ref.read(tenantPageProvider.notifier).showTenantsList();
          },
        ),
        pageTitle: 'Add Tenant',
        introRowWidgets: [],
        scrollableDashboardWidget: TenantForm(),
      ),

      ViewTenantPageState(:final tenant) => DashboardPageStructure(
        introText: 'Tenants',
        pageTitleWidget: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.5),
                child: Center(child: Text(getInitials(tenant.tenantName))),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tenant.tenantName,
                    style: CustomTextStyles.cardDescriptionStyle.copyWith(
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.envelope,
                        color: AppColors.primaryBlue,
                        size: 18,
                      ),
                      SizedBox(width: 3),
                      Text(
                        tenant.tenantEmail ?? 'N/A',
                        style: CustomTextStyles.cardDescriptionStyle.copyWith(),
                      ),
                      SizedBox(width: 1),
                      VerticalDivider(
                        thickness: 2,
                        color: AppColors.primaryBlue,
                      ),
                      SizedBox(width: 1),
                      Icon(
                        CupertinoIcons.phone,
                        color: AppColors.primaryBlue,
                        size: 18,
                      ),
                      SizedBox(width: 3),
                      Text(
                        tenant.tenantPhoneNumber ?? 'N/A',
                        style: CustomTextStyles.cardDescriptionStyle.copyWith(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        introButton: IntroButtonWidget(
          buttonText: 'Back to tenants',
          onPressedCallBack: () {
            ref.read(tenantPageProvider.notifier).showTenantsList();
          },
        ),
        introRowWidgets: [
          ElevatedButtonWidget(
            buttonTitle: 'Update Property',
            buttonIcon: const Icon(CupertinoIcons.pencil),
            onButtonPressedCallBack: () {
              ref.read(tenantPageProvider.notifier).updateTenant(tenant);
            },
          ),
        ],
        scrollableDashboardWidget: SingleTenantPage(tenant: tenant),
      ),

      UpdateTenantPageState(:final tenant) => DashboardPageStructure(
        introText: 'Tenants',
        introButton: IntroButtonWidget(
          buttonText: 'Back to tenants',
          onPressedCallBack: () {
            ref.read(tenantPageProvider.notifier).showTenantsList();
          },
        ),
        pageTitle: 'Update  ${tenant.tenantName}',
        introRowWidgets: [],
        scrollableDashboardWidget: TenantForm(currentTenant: tenant),
      ),
      AddRentEntryState(:final tenant) => DashboardPageStructure(
        introText: 'Tenants',
        introButton: IntroButtonWidget(
          buttonText: 'Back to tenants',
          onPressedCallBack: () {
            ref.read(tenantPageProvider.notifier).showTenantsList();
          },
        ),
        pageTitle: 'Update  ${tenant.tenantName}',
        introRowWidgets: [],
        scrollableDashboardWidget: RentalRecordForm(),
      ),
      ViewRentalMonthState(:final rentalMonth, :final tenant) =>
        DashboardPageStructure(
          introText: 'Tenants',
          introButton: IntroButtonWidget(
            buttonText: 'Back to tenants',
            onPressedCallBack: () {
              ref.read(tenantPageProvider.notifier).showTenantsList();
            },
          ),
          pageTitle: tenant.tenantName,
          supplementaryText: rentalMonth.rentalMonth,
          introRowWidgets: [],
          scrollableDashboardWidget: RentalMonthWidget(
            rentalMonth: rentalMonth,
            tenant: tenant,
          ),
        ),
    };
  }
}
