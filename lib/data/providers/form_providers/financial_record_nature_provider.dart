import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/data/models/enums/financial_record_nature.dart';

part 'financial_record_nature_provider.g.dart';

@riverpod
class FinancialRecordNatureNotifier extends _$FinancialRecordNatureNotifier {
  @override
  FinancialRecordNature? build() {
    return null;
  }

  void fetchNature(FinancialRecordNature nature) {
    state = nature;
  }

  void clearNature() {
    state = null;
  }
}
