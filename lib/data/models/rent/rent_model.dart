import 'package:anyamar/data/models/units/utilities/unit_utilities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rent_model.freezed.dart';
part 'rent_model.g.dart';

@freezed


abstract class Rent with _$Rent {
  const factory Rent({
  required double rentAmount,
   double? rentDeposit,
   String?rentCurrency,
  @Default([]) List<UnitUtility>? utilities,
   String? paymentFrequency,
}) = _Rent;
factory Rent.fromJson(Map<String, dynamic> json) => _$RentFromJson(json);
  
}
