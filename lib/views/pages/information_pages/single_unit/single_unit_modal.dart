import 'package:flutter/cupertino.dart';

import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/data_sets/rent_history.dart';
import 'package:test_app/data/data_sets/tenants.dart';
import 'package:test_app/data/models/rent_history_model.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/pages/information_pages/rent_history/rent_history.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/info_tile.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/single_tenant_page.dart';
import 'package:test_app/views/reusable_widgets/buttons/card_button_widget.dart';
import 'package:test_app/views/reusable_widgets/information_badges/information_badge_widget.dart';

class SingleUnitModal extends StatelessWidget {
  final Unit unit;

  const SingleUnitModal({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    //Get tenant in unit
    Tenant? unitTenant = tenants
        .where((t) => t.tenantId == unit.tenantId)
        .firstOrNull;
    RentHistory rentHisto = rentHistory
        .where((r) => r.unitId == unit.unitId)
        .single;
    return Dialog(
      elevation: 6,
      constraints: BoxConstraints(
        maxWidth: Responsiveness.isMobile(context) ? 400 : 300,
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
                        tileDescription: unit.unitName ?? unit.unitId,
                        onTapCallBack: () {},
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
                              onTapCallBack: () {},
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
                            '${unit.rentCurrency} ${unit.unitRent}',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                //todo:read from list of utilities
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
                      Row(
                        children: [
                          Expanded(
                            child: InfoTile(
                              tileIcon: CupertinoIcons.trash,
                              tileTitle: 'Trash ',
                              tileDescription: 'Ksh 500',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InfoTile(
                              tileIcon: CupertinoIcons.lock,
                              tileTitle: 'Security ',
                              tileDescription: 'Ksh 300',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InfoTile(
                              tileIcon: CupertinoIcons.creditcard,
                              tileTitle: 'Service charge ',
                              tileDescription: 'Ksh 500',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
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
                              onPressedCallBack: () =>
                                  //TODO: FIX BAD STATE TOO MANY ELEMENTS ISSUE
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => RentHistoryPage(
                                        rentHistory: rentHisto,
                                      ),
                                    ),
                                  ),
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
