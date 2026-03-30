import 'package:test_app/data/models/enums/financial_record_nature.dart';
import 'package:test_app/data/models/enums/financial_record_types.dart';

import 'package:test_app/data/models/users/person.dart';

class FinancialRecord {
  final DateTime datePaid;
  final double amountPaid;
  final FinancialRecordTypes recordType;
  final Person? paymentBy;
  final DateTime lastUpdatedDate;
  final FinancialRecordNature isExpense;

  FinancialRecord({
    required this.datePaid,
    required this.amountPaid,
    required this.recordType,
    required this.paymentBy,
    required this.lastUpdatedDate,
    required this.isExpense,
  });
}
