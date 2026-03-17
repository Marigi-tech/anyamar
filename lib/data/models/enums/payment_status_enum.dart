enum PaymentStatus {
  complete('Paid'),
  partial('Incomplete'),
  notPaid('Not Paid');

  final String label;

  const PaymentStatus(this.label);
}
