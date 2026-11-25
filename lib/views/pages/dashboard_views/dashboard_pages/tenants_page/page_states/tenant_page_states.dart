import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/unavailable_info/unavailable_info_model.dart';

//=====================================================
// ADD TENANT
//========================================================

class AddTenantState extends ConsumerWidget {
  final String introText;
  final Unit? unit;

  const AddTenantState({super.key, required this.introText, this.unit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    final allUnits = appData.units;
    final vacantUnits = allUnits
        .where((unit) => unit.isOccupied != true)
        .toList();

    final showUnavailableOverlay = allUnits.isEmpty || vacantUnits.isEmpty;

    final message = allUnits.isEmpty
        ? 'There are currently no units. Kindly add a unit, then assign a tenant to it.'
        : 'All units are currently occupied. Kindly add a new unit or update unoccupied units’ statuses.';

    return DashboardPageStructure(
      introText: '$introText / add tenant',
      pageTitle: 'Add tenant',
      introRowWidgets: [],
      introButton: const IntroButtonWidget(),
      scrollableDashboardWidget: TenantForm(
        introText: '$introText / add tenant',
        currentUnit: unit,
      ),
      unavailableInfo: showUnavailableOverlay
          ? UnavailableInfoModel(
              text: 'Sorry, ${appData.appUser?.userName}',
              supplementaryText: message,
              closeMethod: () =>
                  ref.read(workspaceProvider.notifier).closeWorkspace(),
              ctaButtonWidget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButtonWidget(
                    buttonTitle: 'Close',
                    isClear: true,
                    onButtonPressedCallBack: () =>
                        ref.read(workspaceProvider.notifier).closeWorkspace(),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

//=====================================================
// UPDATE TENANT
//========================================================

class UpdateTenantState extends ConsumerWidget {
  final String introText;
  final Tenant tenant;

  const UpdateTenantState({
    super.key,
    required this.introText,
    required this.tenant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: '$introText / update tenant',
      pageTitle: tenant.tenantName,
      supplementaryText:
          'Phone: ${tenant.tenantPhoneNumber} | Email: ${tenant.tenantEmail ?? 'N/A'} | National ID / Passport number: ${tenant.nationalId ?? 'N/A'}',
      introRowWidgets: [],
      introButton: IntroButtonWidget(),
      scrollableDashboardWidget: TenantForm(
        introText: '$introText / update tenant',
        currentTenant: tenant,
      ),
    );
  }
}
