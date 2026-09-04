import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/custom_data_table.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/dashboard_page_shell.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/properties_page/add_property.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/properties_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';

class PropertiesPage extends ConsumerStatefulWidget {
  const PropertiesPage({super.key});

  @override
  ConsumerState<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends ConsumerState<PropertiesPage> {
  List<Property> myProperties = [];
  List<Property> filteredProperties = [];
  String searchQuery = '';
  List<Unit> myUnits = [];

  void filterPropertyData(String query) {
    setState(() {
      searchQuery = query.trim().toLowerCase();
    });
  }

  List<Property> getFilteredProperies(List<Property> properties) {
    if (searchQuery.isEmpty) {
      return myProperties;
    } else {
      return myProperties
          .where((property) => property.matchesPropertySearch(searchQuery))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );
    myUnits = ref.watch(userInformationProvider.select((state) => state.units));
    filteredProperties = getFilteredProperies(myProperties);

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

          child: CustomDataTable(
            customDataColumns: buildHeaderColumns(),
            customDataRows: filteredProperties.asMap().entries.map((entry) {
              int index = entry.key;
              Property property = entry.value;
              return buildDataRow(property, index + 1, context, myUnits, ref);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
