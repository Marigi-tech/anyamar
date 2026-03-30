import 'package:flutter/material.dart';
import 'package:test_app/data/data_sets/properties.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/views/dashboard_widgets/intro_text_widget.dart';
import 'package:test_app/views/forms/property_forms/add_property.dart';
import 'package:test_app/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:test_app/views/tables/properties_table.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  List<Property> myProperties = [];
  List<Property> filteredProperties = [];

  @override
  void initState() {
    super.initState();

    myProperties = properties.toList();

    filteredProperties = myProperties;
  }

  void filterSinglePropertyTableData(String query) {
    final search = query.toLowerCase();

    setState(() {
      filteredProperties = myProperties
          .where((t) => t.matchesPropertySearch(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraints.maxHeight is the full height available to TenantsPage.
        final double totalHeight = constraints.maxHeight;
        // The ratios are 1:8, totaling 9 parts (1 + 8).
        const int totalFlex = 9;
        final double unitHeight = totalHeight / totalFlex;

        final double headerHeight = unitHeight * 1; // 1/9th of the height
        final double tableHeight = unitHeight * 8; // 8/9ths of the height

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: headerHeight,
              child: IntroTextWidget(dashboardItem: 'Properties'),
            ),

            SizedBox(
              height: tableHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),

                child: Column(
                  children: [
                    TableIntroWidget(
                      dataLength: '${filteredProperties.length}',
                      dataType: 'properties',
                      onSearch: filterSinglePropertyTableData,
                      onPressedCallBack: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AddProperty()),
                      ),
                    ),

                    SizedBox(height: 30),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 30.0,
                        ),
                        child: PropertiesTable(
                          myProperties: filteredProperties,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
