import 'package:anyamar/commons/exports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'property_page_notifier.g.dart';

@riverpod
class PropertyPageNotifier extends _$PropertyPageNotifier {
  @override
  PropertyPageState build() {
    return const PropertiesTablePageState();
  }

  // ------------------------------------------------------------
  // Show properties
  // ------------------------------------------------------------

  void showProperties() {
    state = const PropertiesTablePageState();
  }

  // ------------------------------------------------------------
  // Add property
  // ------------------------------------------------------------

  void showAddProperty() {
    state = const AddPropertyPageState();
  }

  // ------------------------------------------------------------
  // View property
  // ------------------------------------------------------------

  void showProperty(Property property) {
    state = ViewPropertyPageState(property: property);
  }

  // ------------------------------------------------------------
  // Update Property
  // ------------------------------------------------------------

  void showUpdateProperty(Property property) {
    state = EditPropertyPageState(property: property);
  }
}
