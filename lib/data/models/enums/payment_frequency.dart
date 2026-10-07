enum PaymentFrequency {
  monthly('Monthly'),
  weekly('Weekly'),
  daily('Daily'),
  yearly('Yearly');

  final String label;

  const PaymentFrequency(this.label);
}

getFreqFromPaymentFrequency(PaymentFrequency? paymentFrequency) {
  String freq = '';
  if (paymentFrequency == PaymentFrequency.daily) {
    freq = 'day';
  }
  if (paymentFrequency == PaymentFrequency.monthly) {
    freq = 'month';
  }
  if (paymentFrequency == PaymentFrequency.yearly) {
    freq = 'year';
  }
  if (paymentFrequency == PaymentFrequency.weekly) {
    freq = 'week';
  }
  return freq;
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
