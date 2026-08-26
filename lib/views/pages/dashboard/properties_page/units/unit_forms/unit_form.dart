import 'package:anyamar/constants/commons.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/views/forms/dashboard_form.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/units/unit_forms/add_updateunit_form.dart';
import 'package:flutter/cupertino.dart';

class AddUnit extends StatelessWidget {
  final Property? currentProperty;
  final Unit? currentUnit;
  const AddUnit({super.key, this.currentProperty, this.currentUnit});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(
      form: UnitForm(currentProperty: currentProperty, unit: currentUnit),
    );
  }
}
