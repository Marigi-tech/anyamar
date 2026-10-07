import 'package:anyamar/commons/exports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unit_page_notifier.g.dart';

@riverpod
class UnitPageNotifier extends _$UnitPageNotifier {
  @override
  UnitPageState build() {
    return const UnitsTablePageState();
  }

  // ------------------------------------------------------------
  // Unit list
  // ------------------------------------------------------------

  void showUnits() {
    state = const UnitsTablePageState();
  }

  // ------------------------------------------------------------
  // Add unit
  // ------------------------------------------------------------

  void showAddUnit({Property? property}) {
    state = AddUnitPageState(currentProperty: property);
  }

  // ------------------------------------------------------------
  // View unit
  // ------------------------------------------------------------

  void showUnit(Unit unit, {Property? property}) {
    state = ViewUnitPageState(unit: unit, property: property);
  }

  // ------------------------------------------------------------
  // Edit unit
  // ------------------------------------------------------------

  void showEditUnit(Unit unit, {Property? property}) {
    state = EditUnitPageState(unit: unit, property: property);
  }
}
