import 'package:anyamar/data/models/rent/rent_model.dart';
import 'package:anyamar/data/models/rent/single_rental_entry_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_month_model.freezed.dart';
part 'rental_month_model.g.dart';

@freezed
abstract class RentalMonth with _$RentalMonth {
  const factory RentalMonth({
    required String rentalMonth,
    Rent? unitRent,
    @Default([]) List<SingleRentEntry> rentEntries,
    bool? paymentIsCompleted,
  }) = _RentalMonth;

  factory RentalMonth.fromJson(Map<String, dynamic> json) =>
      _$RentalMonthFromJson(json);
}
