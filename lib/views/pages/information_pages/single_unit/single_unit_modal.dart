import 'dart:developer';

import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/units/utilities/unit_utilities.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/tenant_forms/tenant_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/info_tile.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/single_tenant/single_tenant_page.dart';
import 'package:anyamar/views/reusable_widgets/buttons/card_button_widget.dart';
import 'package:anyamar/views/reusable_widgets/information_badges/information_badge_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleUnitModal extends ConsumerWidget {
  final Unit unit;

  const SingleUnitModal({super.key, required this.unit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Get tenant in unit
    Tenant? unitTenant = ref
        .watch(userInformationProvider.select((state) => state.tenants))
        .where((t) => t.tenantId == unit.tenantId)
        .singleOrNull;
    Property? unitProperty = ref
        .watch(userInformationProvider.select((state) => state.properties))
        .where((p) => p.propertyId == unit.propertyId)
        .singleOrNull;
    List<UnitUtility> utilities = unit.unitRent?.utilities ?? [];
    log('Tenant :${unitTenant?.tenantName}');
      log('Proerty :${unitProperty?.propertyName}');
        log('Utilities :${unit.unitRent?.utilities}');
    // RentHistory? rentHisto = rentHistory
    //     .where((r) => r.unitId == unit.unitId)
    //     .singleOrNull;
    return Dialog(
      elevation: 6,

      constraints: BoxConstraints(
        maxWidth: Responsiveness.isMobile(context) ? 400 : 400,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: CloseButton(),
              ),
            ],
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                //? Unit name or Id
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        tileIcon: CupertinoIcons.app_badge,
                        tileTitle: 'Unit: ',
                        tileDescription: unit.unitName,
                      ),
                    ),
                  ],
                ),

                //? Current Tenant Information
                unitTenant != null
                    ? Row(
                        children: [
                          Expanded(
                            child: InfoTile(
                              tileIcon: CupertinoIcons.person,
                              tileTitle: 'Tenant ',
                              tileDescription: unitTenant.tenantName,
                              onTapCallBack: () =>
                                  //redirect to single tenant information
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          SingleTenantPage(tenant: unitTenant),
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        // If there is no tenant display vacancy badge
                        children: [
                          Expanded(
                            child: InfoTile(
                              tileIcon: CupertinoIcons.person,
                              tileTitle: '',
                              tileDescription: '',
                              tileDescriptionWidget: SizedBox(
                                width: 70,
                                height: 30,
                                child: InformationBadge(
                                  text: 'Vacant',
                                  textColor: getOccupancyStatus(
                                    unit.isOccupied,
                                  ).textColor,
                                  badgeColor: getOccupancyStatus(
                                    unit.isOccupied,
                                  ).badgeColor,
                                ),
                              ),
                              //Add tenant for this unit
                              onTapCallBack: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => AddTenant(
                                    currentUnit: unit,
                                    currentProperty: unitProperty,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                //Monthly rent
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        tileIcon: CupertinoIcons.calendar,
                        tileTitle: 'Rent ',
                        tileDescription:
                            '${unit.unitRent?.rentCurrency ?? 'Ksh'} ${unit.unitRent?.rentAmount}',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                //read from list of utilities
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Utilities',
                          style: CustomTextStyles.cardDescriptionStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      if (utilities.isNotEmpty)
                        ...utilities.map((item) {
                          return Row(
                            children: [
                              Expanded(
                                child: InfoTile(
                                  tileIcon: getUtilityIcon(item.utilityName),
                                  tileTitle: item.utilityName.label,
                                  tileDescription: 'Ksh ${item.amountPayable}',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          );
                        }),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //todo:Tenant history
                      Row(
                        children: [
                          Expanded(
                            child: CardButtonWidget(
                              onPressedCallBack: () {},
                              buttonTitle: 'view tenant history',
                            ),
                          ),
                        ],
                      ),

                      //Rent History
                      Row(
                        children: [
                          Expanded(
                            child: CardButtonWidget(
                              onPressedCallBack: () {},
                              //TO DO: FIX BAD STATE TOO MANY ELEMENTS ISSUE
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (_) => RentHistoryPage(
                              //       rentHistory: rentHisto,
                              //     ),
                              //   ),
                              // ),
                              buttonTitle: 'view rent history',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
