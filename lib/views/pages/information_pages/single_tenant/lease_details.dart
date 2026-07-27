import 'package:flutter/cupertino.dart';
import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/date_format_model.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/views/pages/information_pages/single_tenant/info_tile.dart';

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
           
          ],
        ),
      ),
    );
  }
}
