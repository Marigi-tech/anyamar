import 'package:anyamar/data/models/date_format_model.dart';
import 'package:anyamar/data/models/enums/financial_record_nature.dart';
import 'package:anyamar/data/models/enums/financial_record_types.dart';
import 'package:anyamar/data/models/enums/payment_methods_enum.dart';

import 'package:anyamar/data/models/users/person.dart';

class FinancialRecord {
  final DateTime datePaid;
  final double amountPaid;
  final FinancialRecordTypes recordType;
  final Person paymentBy;
  final DateTime lastUpdatedDate;
  final FinancialRecordNature recordNature;
  final String recordId;
  final PaymentMethods paymentMethod;

  FinancialRecord({
    required this.datePaid,
    required this.amountPaid,
    required this.recordType,
    required this.paymentBy,
    required this.lastUpdatedDate,
    required this.recordNature,
    required this.recordId,
    required this.paymentMethod,
  });
  bool matchesFinancialRecordsSearch(String query) {
    final search = query.toLowerCase();

    return recordId.toLowerCase().contains(search.toLowerCase()) ||
        (formatMonthName(
          datePaid,
        ).toString().toLowerCase().contains(search.toLowerCase())) ||
        (recordType.label).toLowerCase().contains(search) ||
        (paymentBy.userName).toLowerCase().contains(search.toLowerCase()) ||
        (amountPaid.toString()).toLowerCase().contains(search.toLowerCase()) ||
        (paymentMethod.label).toLowerCase().contains(search.toLowerCase()) ||
        (datePaid.toString()).toLowerCase().contains(search);
  }
}
