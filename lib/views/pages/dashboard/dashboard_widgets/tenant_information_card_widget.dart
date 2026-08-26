import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/single_tenant_page.dart';
import 'package:anyamar/views/reusable_widgets/buttons/button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';

class TenantInformationCardWidget extends ConsumerWidget {
  final bool isUnitTenant; // if not a unit tenant then it's a property tenant
  final Property? property;
  const TenantInformationCardWidget({
    super.key,
    this.isUnitTenant = false,
    this.property,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Property> myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    final List<Tenant> myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );
    //List of alternating avatar colors
    final List<Color> avatarBackgroundColors = [
      AppColorsConstant.darkBlueColor,
      AppColorsConstant.darkGreenColor,
      AppColorsConstant.darkYellowColor,
      AppColorsConstant.redColor,
    ];
    return ValueListenableBuilder(
      valueListenable: selectedWebPageNotifier,
      builder: (context, value, child) {
        return Container(
          width: Responsiveness.isDesktop(context)
              ? getSizeFromContext(context).width * .50
              : double.infinity,
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                //Enter card title here
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tenants',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isUnitTenant != true)
                        Row(
                          children: [
                            //View button
                            ColorButtonWidget(
                              onPressedCallBack: () {
                                selectedWebPageNotifier.value = 3;
                              },
                              buttonTitle: 'View all',
                              fontSize: 11,
                              buttonColor: AppColorsConstant.greenColor,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                //Divider
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(thickness: 0.18, height: 10.0),
                ),
                SizedBox(height: 10.0),

                Expanded(
                  child: ListView.separated(
                    itemCount: isUnitTenant
                        ? myTenants
                              .where(
                                (tenant) =>
                                    tenant.propertyId == property?.propertyId,
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
                                  (tenant) =>
                                      tenant.propertyId == property?.propertyId,
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
                                          property.propertyId ==
                                          tenant.propertyId,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
