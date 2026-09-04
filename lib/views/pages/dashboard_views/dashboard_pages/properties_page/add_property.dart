import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/views/reusable_widgets/dashboard_form_widget.dart';
import 'package:anyamar/forms/add_property_form.dart';

class AddProperty extends StatelessWidget {
  final Property? currentProperty;
  final bool? isFromUnitPage;
  const AddProperty({super.key, this.currentProperty, this.isFromUnitPage});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(form: AddPropertyForm(currentProperty: currentProperty , isFromUnitPage: isFromUnitPage));
  }
}
