import 'package:anyamar/data/models/unit_utilities.dart';

class Rent {
  final double rentAmount;
  final double rentDeposit;
  final String rentCurrency;
  final List<UnitUtility>? utilities;
  final String? paymentFrequency;

  Rent({
    required this.rentAmount,
    required this.rentDeposit,
    required this.rentCurrency,
    this.utilities,
    this.paymentFrequency,
  });
}
