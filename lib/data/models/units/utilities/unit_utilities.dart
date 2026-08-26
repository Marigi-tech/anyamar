import 'package:anyamar/data/models/enums/property_utilities_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_utilities.freezed.dart';
part 'unit_utilities.g.dart';

@freezed
abstract class UnitUtility with _$UnitUtility {
const factory UnitUtility ({
  required PropertyUtility utilityName,
  required double amountPayable,
}) = _UnitUtility;

factory UnitUtility.fromJson(Map<String, dynamic> json) => _$UnitUtilityFromJson(json);
  
}
