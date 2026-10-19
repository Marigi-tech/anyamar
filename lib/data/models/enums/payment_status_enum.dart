enum PaymentStatus {
  pending('Pending'),
  complete('Complete'),
  partial('Incomplete'),
  notPaid('Not Paid'),
  excess('Excess'),
  undefined('Undefined');

  final String label;

  const PaymentStatus(this.label);
}
