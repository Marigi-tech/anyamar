import 'package:anyamar/data/models/unit_model.dart';

class Property {
  final String propertyId;
  final String propertyName;
  final String propertyLocation;
  final String propertyManager;
  final String? propertyImage;
  final List<Unit>? propertyUnits;

  Property({
    required this.propertyId,
    required this.propertyName,
    required this.propertyLocation,
    required this.propertyManager,
    this.propertyImage,
    this.propertyUnits,
  });
  bool matchesPropertySearch(String query) {
    final search = query.toLowerCase();

    return propertyId.toLowerCase().contains(search.toLowerCase()) ||
        (propertyName).toLowerCase().contains(search.toLowerCase()) ||
        (propertyLocation).toLowerCase().contains(search) ||
        (propertyManager).toLowerCase().contains(search.toLowerCase());
  }
}
