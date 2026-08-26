import 'package:freezed_annotation/freezed_annotation.dart';

part 'rent_history_model.freezed.dart';
part 'rent_history_model.g.dart';

@freezed
abstract class RentHistory with _$RentHistory {
  const factory RentHistory({
    String? historyId,
    required String tenantId,
    required String unitId,
    String? propertyId,
    required String userId,
    @Default([]) List<Map<String, dynamic>> rentEntries,
    String? tenantName,
  }) = _RentHistory;

  factory RentHistory.fromJson(Map<String, dynamic> json) =>
      _$RentHistoryFromJson(json);
}
