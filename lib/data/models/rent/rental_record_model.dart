import 'package:anyamar/commons/exports.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_record_model.freezed.dart';
part 'rental_record_model.g.dart';

@freezed
abstract class RentalRecord with _$RentalRecord {
  const factory RentalRecord({
    required String tenantId,
    required String unitId,
    required SingleRentEntry rentEntry,
    required RentalMonth rentalMonth,
    required RentHistory rentHistory,
  }) = _RentalRecord;

  factory RentalRecord.fromJson(Map<String, dynamic> json) =>
      _$RentalRecordFromJson(json);
}
