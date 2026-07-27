import 'package:anyamar/data/models/date_format_model.dart';
import 'package:anyamar/data/models/unit_utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/info_tile.dart';

class TenantDetails extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.person,
                    tileTitle: 'Name',
                    tileDescription: tenant.tenantName,
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
                    tileDescription: tenant.tenantEmail ?? '',
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
                    tileDescription: tenant.tenantPhoneNumber,
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
                    tileDescription: property.propertyLocation,
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
                    tileDescription: tenant.tenantName,
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
            //Emergency Contact
            Row(
              children: [
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.phone,
                    tileTitle: 'Emergency contact',
                    tileDescription: tenant.tenantPhoneNumber,
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
                        'Rent / ${unit.unitRent.paymentFrequency ?? 'Month'} ',
                    tileDescription:
                        ' ${unit.unitRent.rentCurrency}  ${unit.unitRent.rentAmount}',
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
                        ' ${unit.unitRent.rentCurrency}  ${unit.unitRent.rentDeposit}',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),

            //List of utilities
            // Padding(
            //   padding: EdgeInsets.only(left: 20.0),
            //   child: ListView.builder(
            //     itemBuilder: (context, index) {
            //       final UnitUtility? utility = unit.unitRent.utilities?[index];
            //       return utility != null
            //           ? Row(
            //               children: [
            //                 //Name
            //                 Expanded(
            //                   child: InfoTile(
            //                     tileIcon: CupertinoIcons.calendar,
            //                     tileTitle: utility.utilityName.label,
            //                     tileDescription:
            //                         '${unit.unitRent.rentCurrency} ${utility.amountPayable}',
            //                     onTapCallBack: () {},
            //                   ),
            //                 ),
            //               ],
            //             )
            //           : SizedBox();
            //     },
            //   ),
            // ),
            Row(
              children: [
                //Name
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.calendar,
                    tileTitle: 'Start date',
                    tileDescription: formatPrettyDate(DateTime.now()),
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),

            Row(
              children: [
                //End date
                Expanded(
                  child: InfoTile(
                    tileIcon: CupertinoIcons.calendar,
                    tileTitle: 'End date',
                    tileDescription: formatPrettyDate(DateTime.now()),
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
                    tileDescription: 'Monthly ',
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
                    tileDescription: 'lease.doc',
                    onTapCallBack: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
