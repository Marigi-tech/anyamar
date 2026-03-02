import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/data/models/unit_types_model.dart';

final List<Unit> units = [
  Unit(
    unitId: "U001",
    unitName: "U001",
    propertyId: "P001",
    tenantId: "T001",
    isOccupied: true,
    unitType: UnitType.airbnb,
  ),
  Unit(
    unitId: "U002",
    unitName: "U002",
    propertyId: "P002",
    tenantId: "T002",
    isOccupied: true,
    unitType: UnitType.studio,
  ),
  Unit(
    unitId: "U003",
    unitName: "U003",
    propertyId: "P003",
    tenantId: "T003",
    isOccupied: true,
    unitType: UnitType.oneBedroom,
  ),
  Unit(
    unitId: "U004",
    unitName: "Sunset AB",
    propertyId: "P001",
    tenantId: "T004",
    isOccupied: true,
    unitType: UnitType.twoBedroom,
  ),
  Unit(
    unitId: "U005",
    unitName: "Sunset AA",
    propertyId: "P001",
    tenantId: "T005",
    isOccupied: true,
    unitType: UnitType.oneBedroom,
  ),
  Unit(
    unitId: "U006",
    unitName: "Sunset AC",
    propertyId: "P001",

    isOccupied: false,
    unitType: UnitType.oneBedroom,
  ),
  Unit(
    unitId: "U007",
    unitName: "Sunset AD",
    propertyId: "P001",
    isOccupied: false,
    unitType: UnitType.oneBedroom,
  ),
  Unit(
    unitId: "U008",
    unitName: "Sunset AF",
    propertyId: "P001",
    isOccupied: false,
    unitType: UnitType.oneBedroom,
  ),
];
