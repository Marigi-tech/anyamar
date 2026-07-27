import 'package:flutter/material.dart';
import 'package:anyamar/data/data_sets/units.dart';
import 'package:anyamar/data/models/property_model.dart';
import 'package:anyamar/data/models/unit_model.dart';
import 'package:anyamar/views/forms/unit_forms/unit_form.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/tables/units_table.dart';

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

    propertyUnits = tempunits
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
            onPressedCallBack: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddUnit())),
        ),

        SizedBox(height: 30),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
            child: UnitsTable(units: filteredUnits),
          ),
        ),
      ],
    );
  }
}
