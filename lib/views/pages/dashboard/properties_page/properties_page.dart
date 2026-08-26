import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_page_shell.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/property_forms/add_property.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/properties_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';

class PropertiesPage extends ConsumerStatefulWidget {
  const PropertiesPage({super.key});

  @override
  ConsumerState<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends ConsumerState<PropertiesPage> {
  List<Property> myProperties = [];
  List<Unit> myUnits = [];
  List<Property> filteredProperties = [];

  @override
  void initState() {
    super.initState();
  }

  void filterPropertyData(String query) {
    final search = query.toLowerCase();

    setState(() {
      filteredProperties = myProperties
          .where((t) => t.matchesPropertySearch(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    myUnits = ref.watch(userInformationProvider.select((state) => state.units));
    filteredProperties = myProperties;
    return DashboardPageShell(
      introText: 'Properties',
      stickyWidget: TableIntroWidget(
        dataLength: '${filteredProperties.length}',
        dataType: 'Properties',
        onSearch: filterPropertyData,
        hasSearchBar: true,
        onPressedCallBack: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => AddProperty())),
      ),
      dashboardWidgets: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: PropertiesTable(
            myProperties: filteredProperties,
            myUnits: myUnits,
          ),
        ),
      ],
    );
  }
}
