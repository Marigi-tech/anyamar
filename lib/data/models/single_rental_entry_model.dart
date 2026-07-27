import 'package:anyamar/data/models/enums/payment_methods_enum.dart';

class SingleRentEntry {
  final DateTime paymentDate;
  final double amountPayable;
  final double amountPaid;
  final double? balance;
  final PaymentMethods paymentMethod;
  final String rentalMonth;

  SingleRentEntry({
    required this.paymentDate,
    required this.amountPayable,
    required this.amountPaid,
    this.balance,
    required this.paymentMethod,
    required this.rentalMonth,
  });
}
