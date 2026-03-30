import 'package:test_app/data/models/enums/financial_record_nature.dart';

enum FinancialRecordTypes {
  rent('Rent', FinancialRecordNature.revenue),
  rentdeposit('Rent deposit', FinancialRecordNature.revenue),
  securityExpense('Security bill', FinancialRecordNature.expense),
  waterExpense('Water bill', FinancialRecordNature.expense),
  electrityExpense('Electricity bill', FinancialRecordNature.expense),
  otherExpense('Other expense', FinancialRecordNature.expense),
  otherRevenueSource('Other revenue source', FinancialRecordNature.expense);

  final FinancialRecordNature nature;

  final String label;

  const FinancialRecordTypes(this.label, this.nature);
}
