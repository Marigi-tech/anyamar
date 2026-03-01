import 'package:flutter/material.dart';
import 'package:test_app/data/data_sets/units.dart';
import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/unit_model.dart';
import 'package:test_app/views/widgets/table_intro_widget/table_intro_widget.dart';
import 'package:test_app/views/widgets/tables/units_table.dart';

class PropertyUnits extends StatefulWidget {
  final Property property;
  const PropertyUnits({super.key, required this.property});

  @override
  State<PropertyUnits> createState() => _PropertyUnitsState();
}

class _PropertyUnitsState extends State<PropertyUnits> {
  List<Unit> propertyUnits = [];
  List<Unit> filteredUnits = [];

  @override
  void initState() {
    super.initState();

    propertyUnits = units
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();

    filteredUnits = propertyUnits;
  }

  void filterSingleUnitTableData(String query) {
    final search = query.toLowerCase();

    setState(() {
      filteredUnits = propertyUnits
          .where((u) => u.matchesUnitSearch(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TableIntroWidget(
          dataLength: '${filteredUnits.length}',
          dataType: 'Units',
          onSearch: filterSingleUnitTableData,
        ),

        SizedBox(height: 30),
        UnitsTable(units: filteredUnits),
      ],
    );
  }
}
