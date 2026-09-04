import 'package:flutter/material.dart';
import 'package:anyamar/views/reusable_widgets/dashboard_form_widget.dart';

class AddExpenseRecord extends StatelessWidget {
  const AddExpenseRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardForm(form: ExpenseRecordForm());
  }
}

class ExpenseRecordForm extends StatelessWidget {
  const ExpenseRecordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
