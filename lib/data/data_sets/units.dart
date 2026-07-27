import 'package:anyamar/data/models/enums/property_utilities_enum.dart';
import 'package:anyamar/data/models/rent_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/data/models/unit_utilities.dart';

final List<Unit> tempunits = [
  Unit(
    unitId: "U001",
    unitName: "U001",
    propertyId: "P001",
    tenantId: "T001",
    unitRent: Rent(
      rentAmount: 30000,
      rentDeposit: 30300,
      rentCurrency: 'Ksh',
      paymentFrequency: 'Monthly',
    ),
    isOccupied: true,
  ),
  Unit(
    unitId: "U002",
    unitName: "U002",
    propertyId: "P002",
    tenantId: "T002",
    isOccupied: true,
    unitRent: Rent(
      rentAmount: 40000,
      rentDeposit: 40300,
      rentCurrency: 'Ush',
      paymentFrequency: 'Monthly',
    ),
  ),
  Unit(
    unitId: "U003",
    unitName: "U003",
    propertyId: "P003",
    tenantId: "T003",
    isOccupied: true,
    unitRent: Rent(
      rentAmount: 1000,
      rentDeposit: 1000,
      rentCurrency: 'Dollars',
      paymentFrequency: 'Bi Monthly',
    ),
  ),
  Unit(
    unitId: "U004",
    unitName: "Sunset AB",
    propertyId: "P001",
    tenantId: "T004",
    isOccupied: true,
    unitRent: Rent(
      rentAmount: 30000,
      rentDeposit: 30300,
      rentCurrency: 'Ksh',
      paymentFrequency: 'Monthly',
    ),
  ),
  Unit(
    unitId: "U005",
    unitName: "Sunset AA",
    propertyId: "P001",
    tenantId: "T005",
    isOccupied: true,
    unitRent: Rent(
      rentAmount: 30000,
      rentDeposit: 30300,
      rentCurrency: 'Ksh',
      paymentFrequency: 'Monthly',
    ),
  ),
  Unit(
    unitId: "U006",
    unitName: "Sunset AC",
    propertyId: "P001",
    isOccupied: false,
    unitRent: Rent(
      rentAmount: 25000,
      rentDeposit: 25300,
      rentCurrency: 'Ksh',
      paymentFrequency: 'Monthly',
    ),
  ),
  Unit(
    unitId: "U007",
    unitName: "Sunset AD",
    propertyId: "P001",
    isOccupied: false,
    unitRent: Rent(
      rentAmount: 30000,
      rentDeposit: 30300,
      rentCurrency: 'Ksh',
      paymentFrequency: 'Monthly',
    ),
  ),
  Unit(
    unitId: "U008",
    unitName: "Sunset AF",
    propertyId: "P001",
    isOccupied: false,
    unitRent: Rent(
      rentAmount: 30000,
      rentDeposit: 30300,
      rentCurrency: 'Ksh',
      paymentFrequency: 'Monthly',
      utilities: [
        UnitUtility(utilityName: PropertyUtility.garbage, amountPayable: 700),
        UnitUtility(
          utilityName: PropertyUtility.electricity,
          amountPayable: 500,
        ),
      ],
    ),
  ),
];
