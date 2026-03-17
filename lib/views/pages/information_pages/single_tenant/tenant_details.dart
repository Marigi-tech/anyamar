import 'package:flutter/cupertino.dart';
import 'package:test_app/data/constants/commons.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/pages/information_pages/single_tenant/info_tile.dart';

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
          ],
        ),
      ),
    );
  }
}
