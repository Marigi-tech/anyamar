import 'package:anyamar/data/models/date_format/date_format_model.dart';
import 'package:anyamar/views/reusable_widgets/information_badges/information_badge_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/tenants_page/single_tenant/info_tile.dart';

class TenantDetails extends StatefulWidget {
  final Tenant tenant;
  final Property property;
  final Unit unit;
  const TenantDetails({
    super.key,
    required this.tenant,
    required this.property,
    required this.unit,
  });

  @override
  State<TenantDetails> createState() => _TenantDetailsState();
}

class _TenantDetailsState extends State<TenantDetails> {
  double totalAmountPayableMonthly = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.unit.unitRent != null) {
      widget.unit.unitRent!.rentAmount +
          (widget.unit.unitRent?.utilities ?? []).fold<double>(
            0,
            (sum, utility) => sum + utility.amountPayable,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.person,
                  tileTitle: 'Name',
                  tileDescription: widget.tenant.tenantName,
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),

          //Email
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.envelope,
                  tileTitle: 'Email',
                  tileDescription: widget.tenant.tenantEmail ?? '',
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.phone,
                  tileTitle: 'Phone',
                  tileDescription: widget.tenant.tenantPhoneNumber ?? '',
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),

          //Location
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.location,
                  tileTitle: 'Location',
                  tileDescription: widget.property.propertyLocation,
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),
          //Occupation
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.question,
                  tileTitle: 'Occupation',
                  tileDescription: widget.tenant.tenantOccupation ?? '',
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              //Start of lease
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.calendar,
                  tileTitle: 'Lease start',
                  tileDescription: formatPrettyDate(widget.tenant.startOfLease),
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),
          if (widget.tenant.endOfLease != null)
            Row(
              children: [
                //End of lease
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.calendar,
                    tileTitle: 'Lease end',
                    tileDescription: formatPrettyDate(
                      widget.tenant.endOfLease!,
                    ),
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
          //Rent Deposit
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.money_dollar,
                  tileTitle: 'Rent Deposit ',
                  tileDescription:
                      ' ${widget.unit.unitRent?.rentCurrency ?? 'Ksh'}  ${widget.unit.unitRent?.rentDeposit}',
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),
          //Rent
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.money_dollar,
                  tileTitle:
                      'Rent / ${widget.unit.unitRent?.paymentFrequency ?? 'Month'} ',
                  tileDescription:
                      ' ${widget.unit.unitRent?.rentCurrency}  ${widget.unit.unitRent?.rentAmount}',
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),

          SizedBox(height: 10.0),
          // Utilities
          if (widget.unit.unitRent?.utilities != null &&
              widget.unit.unitRent!.utilities!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Utilities',
                      style: CustomTextStyles.cardDescriptionStyle.copyWith(
                        color: AppColorsConstant.kGreen6,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 7),

                  ...widget.unit.unitRent!.utilities!.map((utility) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InfoTile(
                              tileIcon: getUtilityIcon(utility.utilityName),
                              tileTitle: utility.utilityName.label,
                              tileDescription:
                                  'Ksh ${utility.amountPayable.toStringAsFixed(2)}',
                              onTapCallBack: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          //Total amount payable
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.question,
                  tileTitle: 'Monthly Total:',
                  tileDescription:
                      'ksh ${totalAmountPayableMonthly.toStringAsFixed(2)}',
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),
          //Payment terms
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.money_dollar,
                  tileTitle: 'Payment terms',
                  tileDescription:
                      widget.unit.unitRent?.paymentFrequency ?? '/Month',
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),
          //Lease agreement
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  tileIcon: CupertinoIcons.cloud_download,
                  tileTitle: 'Lease agreement',
                  tileDescription: '',
                  onTapCallBack: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          //Emergency Contact
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0, bottom: 20.0),
                  child: Text(
                    'Emergency Contact Information',
                    style: CustomTextStyles.cardDescriptionStyle.copyWith(
                      color: AppColorsConstant.kOrange2,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                //Name
                Row(
                  children: [
                    Expanded(
                      child: InfoTile(
                        tileIcon: Icons.person,
                        tileTitle: 'Name',
                        tileDescription:
                            widget.tenant.nextOfKin?.personName ?? '',
                        onTapCallBack: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                if (widget.tenant.nextOfKin?.personPhone != null)
                  //Phone Number
                  Row(
                    children: [
                      Expanded(
                        child: InfoTile(
                          tileIcon: Icons.phone,
                          tileTitle: 'Phone ',
                          tileDescription:
                              widget.tenant.nextOfKin?.personPhone ?? '',
                          onTapCallBack: () {},
                        ),
                      ),
                    ],
                  ),
                if (widget.tenant.nextOfKin?.personEmail != null)
                  //Email
                  Row(
                    children: [
                      Expanded(
                        child: InfoTile(
                          tileIcon: CupertinoIcons.envelope,
                          tileTitle: 'Email',
                          tileDescription:
                              widget.tenant.nextOfKin?.personEmail ?? '',
                          onTapCallBack: () {},
                        ),
                      ),
                    ],
                  ),
                if (widget.tenant.nextOfKin?.relationship != null)
                  //Tenant relationship
                  Row(
                    children: [
                      Expanded(
                        child: InfoTile(
                          tileIcon: Icons.person,
                          tileTitle: 'Relationship',
                          tileDescription:
                              'Tenant\'s ${widget.tenant.nextOfKin?.relationship ?? ''}',
                          onTapCallBack: () {},
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
