enum PaymentMethods {
  cash('Cash'),
  mpesa('M-Pesa'),
  bank('Bank'),
  paypal('PayPal');

  final String label;

  const PaymentMethods(this.label);
}
