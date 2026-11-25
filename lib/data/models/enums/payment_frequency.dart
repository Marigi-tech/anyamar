enum PaymentFrequency {
  monthly('Monthly'),
  weekly('Weekly'),
  daily('Daily'),
  yearly('Yearly');

  final String label;

  const PaymentFrequency(this.label);
}

getFreqFromPaymentFrequency(PaymentFrequency? paymentFrequency) {
  if (paymentFrequency == PaymentFrequency.daily) {
    return 'day';
  }
  if (paymentFrequency == PaymentFrequency.monthly) {
    return 'month';
  }
  if (paymentFrequency == PaymentFrequency.yearly) {
    return 'year';
  }
  if (paymentFrequency == PaymentFrequency.weekly) {
    return 'week';
  }
}

getFrequencyFromFreq(String? frequency) {
  PaymentFrequency? paymentFrequency;
  if (frequency == 'day') {
    paymentFrequency = PaymentFrequency.daily;
  }
  if (frequency == 'month') {
    paymentFrequency = PaymentFrequency.monthly;
  }
  if (frequency == 'year') {
    paymentFrequency = PaymentFrequency.yearly;
  }
  if (frequency == 'week') {
    paymentFrequency = PaymentFrequency.weekly;
  }
  return paymentFrequency;
}
