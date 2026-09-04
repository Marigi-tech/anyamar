import 'package:flutter/material.dart';
import 'package:anyamar/views/reusable_widgets/dashboard_form_widget.dart';

class AddRentRevenue extends StatelessWidget {
  
  const AddRentRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(form: RentRevenueForm());
  }
}

class RentRevenueForm extends StatelessWidget {
  const RentRevenueForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('General financial record');
  }
}
