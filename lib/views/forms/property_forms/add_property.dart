import 'package:flutter/material.dart';
import 'package:test_app/views/forms/dashboard_form.dart';
import 'package:test_app/views/forms/property_forms/add_property_form.dart';

class AddProperty extends StatelessWidget {
  const AddProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(form: AddPropertyForm());
  }
}
