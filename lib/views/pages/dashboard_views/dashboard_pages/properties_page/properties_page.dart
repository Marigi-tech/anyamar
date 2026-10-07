import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/page_states/add_property_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/page_states/property_table_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/page_states/update_property_state_page.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/page_states/view_property_state_page.dart';

// ============================================================
// PAGE STATES
// ============================================================
sealed class PropertyPageState {
  const PropertyPageState();
}

class PropertiesTablePageState extends PropertyPageState {
  const PropertiesTablePageState();
}

class AddPropertyPageState extends PropertyPageState {
  const AddPropertyPageState();
}

class ViewPropertyPageState extends PropertyPageState {
  final Property property;
  const ViewPropertyPageState({required this.property});
}

class EditPropertyPageState extends PropertyPageState {
  final Property property;

  const EditPropertyPageState({required this.property});
}

// ============================================================
// BASE PROPERTY PAGE
// ============================================================
class PropertiesPage extends ConsumerStatefulWidget {
  const PropertiesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends ConsumerState<PropertiesPage> {
  @override
  Widget build(BuildContext context) {
    final propertyPageState = ref.watch(propertyPageProvider);

    return switch (propertyPageState) {
      PropertiesTablePageState() => PropertyTableStatePage(),
      AddPropertyPageState() => AddPropertyStatePage(),

      ViewPropertyPageState(:final property) => ViewPropertyStatePage(
        property: property,
      ),

      EditPropertyPageState(:final property) => UpdatePropertyStatePage(
        property: property,
      ),
    };
  }
}
