enum FinancialRecordNature {
  expense('Expense'),
  revenue('Revenue');

  final String label;

  const FinancialRecordNature(this.label);
}
