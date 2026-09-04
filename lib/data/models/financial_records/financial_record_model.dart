import 'package:anyamar/data/models/date_format/date_format_model.dart';
import 'package:anyamar/data/models/enums/financial_record_nature.dart';
import 'package:anyamar/data/models/enums/financial_record_types.dart';
import 'package:anyamar/data/models/enums/payment_methods_enum.dart';
import 'package:anyamar/data/models/users/person/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_record_model.freezed.dart';
part 'financial_record_model.g.dart';

@freezed
abstract class FinancialRecord with _$FinancialRecord {
  const factory FinancialRecord({
    required DateTime datePaid,
    required double amountPaid,
    required FinancialRecordTypes recordType,
    required Person paymentBy,
    DateTime? lastUpdatedDate,
    required FinancialRecordNature recordNature,
    String? recordId,
    PaymentMethods? paymentMethod,
    String? userId,
    String? propertyId,
  }) = _FinancialRecord;

  factory FinancialRecord.fromJson(Map<String, dynamic> json) =>
      _$FinancialRecordFromJson(json);
}

extension FinancialRecordSearch on FinancialRecord {
  bool matchesFinancialRecordsSearch(String query) {
    final search = query.toLowerCase();

    return (formatMonthName(
          datePaid,
        ).toString().toLowerCase().contains(search.toLowerCase())) ||
        (recordType.label).toLowerCase().contains(search) ||
        (paymentBy.personName).toLowerCase().contains(search.toLowerCase()) ||
        (amountPaid.toString()).toLowerCase().contains(search.toLowerCase()) ||
        (paymentMethod?.label ?? '').toLowerCase().contains(
          search.toLowerCase(),
        ) ||
        (datePaid.toString()).toLowerCase().contains(search);
  }
}
