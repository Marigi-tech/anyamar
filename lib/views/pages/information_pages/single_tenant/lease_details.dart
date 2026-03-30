import 'package:flutter/cupertino.dart';
import 'package:test_app/constants/commons.dart';
import 'package:test_app/data/models/date_format_model.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/info_tile.dart';

class LeaseDetails extends StatelessWidget {
  final Tenant tenant;
  final Property property;
  final Unit unit;
  const LeaseDetails({
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
