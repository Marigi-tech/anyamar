import 'package:anyamar/data/models/enums/payment_methods_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_rental_entry_model.freezed.dart';
part 'single_rental_entry_model.g.dart';

@freezed
abstract class SingleRentEntry with _$SingleRentEntry {
  const factory SingleRentEntry({
    required DateTime paymentDate,
    required double amountPayable,
    required double amountPaid,
    double? balance,
    required PaymentMethods paymentMethod,
    required String rentalMonth,
    DateTime? lastUpdatedDate,
    String? rentEntryId,
    String? transactionCode,
  }) = _SingleRentalEntry;

  factory SingleRentEntry.fromJson(Map<String, dynamic> json) =>
      _$SingleRentEntryFromJson(json);

  // factory SingleRentEntry.toJson(Map<String, dynamic> json) =>
  //     _$SingleRentEntryFromJson(json);
}
