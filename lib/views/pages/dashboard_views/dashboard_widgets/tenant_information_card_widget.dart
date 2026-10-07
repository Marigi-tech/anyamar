import 'package:anyamar/commons/exports.dart';

class TenantInformationCardWidget extends ConsumerWidget {
  final bool isUnitTenant; // if not a unit tenant then it's a property tenant
  final Property? property;
  final List<Tenant>? tenants;
  const TenantInformationCardWidget({
    super.key,
    this.isUnitTenant = false,
    this.property,
    this.tenants,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Property> myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    final List<Tenant> myTenants =
        tenants ??
        ref.watch(userInformationProvider.select((state) => state.tenants));

    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return DashboardCardWidget(
          cardTitle: 'Tenants ',
          buttonWidget1: AppTextButton(
            onPressedCallBack: () {
              selectedWebPageNotifier.value = 3;
              selectedSideItemNotifier.value = 3;
            },
            buttonTitle: 'View all',
            buttonColor: AppColors.buttonBlueColor,
          ),

          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: isUnitTenant
                ? myTenants
                      .where(
                        (tenant) => tenant.propertyId == property?.propertyId,
                      )
                      .length
                : myTenants.length,

            separatorBuilder: (_, __) =>
                const Divider(height: 12, thickness: 0.15),
            itemBuilder: (context, index) {
              // final tenant = mytenants[index];

              final Tenant tenant = isUnitTenant
                  ? myTenants
                        .where(
                          (tenant) => tenant.propertyId == property?.propertyId,
                        )
                        .toList()[index]
                  : myTenants[index];

              return ListTile(
                leading: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      avatarBackgroundColors[index %
                          avatarBackgroundColors.length],
                  child: Text(
                    tenant.tenantName[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      color: AppColorsConstant.whiteColor,
                    ),
                  ),
                ),
                title: Text(
                  tenant.tenantName,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  isUnitTenant
                      ? tenant.unitName ?? ''
                      : myProperties
                            .where(
                              (property) =>
                                  property.propertyId == tenant.propertyId,
                            )
                            .single
                            .propertyName,

                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColorsConstant.blueGreyColor,
                  ),
                ),
                onTap: () {
                  //This is the tenant
                  // log('This is the tenant: ${tenant.tenantName}');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SingleTenantPage(tenant: tenant),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
