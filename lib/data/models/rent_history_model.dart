import 'package:test_app/data/models/single_rental_entry_model.dart';

class RentHistory {
  final String tenantId;
  final String unitId;
  final String propertyId;
  final List<SingleRentEntry>? rentEntries;

  RentHistory({
    required this.tenantId,
    required this.unitId,
    required this.propertyId,
    this.rentEntries,
  });
}
