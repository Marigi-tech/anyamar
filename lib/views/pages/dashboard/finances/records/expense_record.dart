import 'package:flutter/material.dart';
import 'package:anyamar/views/forms/dashboard_form.dart';

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
