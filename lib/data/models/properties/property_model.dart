import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/data/models/users/person/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'property_model.freezed.dart';
part 'property_model.g.dart';

@freezed
abstract class Property with _$Property {
  const factory Property({
    String? propertyId,
    required String propertyName,
    required String propertyLocation,
    Person? propertyManager,
    String? propertyImage,
    required String userId,
    @Default([]) List<Unit> propertyUnits,
    @Default(0) int propertyFloors,
    DateTime? lastUpdatedDate,
  }) = _Property;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}

extension PropertySearch on Property {
  bool matchesPropertySearch(String query) {
    final search = query.toLowerCase();

    return (propertyName).toLowerCase().contains(search.toLowerCase()) ||
        (propertyLocation).toLowerCase().contains(search) ||
        (propertyManager?.personName ?? '').toLowerCase().contains(
          search.toLowerCase(),
        ) ||
        (propertyFloors.toString().contains(search));
  }
}
