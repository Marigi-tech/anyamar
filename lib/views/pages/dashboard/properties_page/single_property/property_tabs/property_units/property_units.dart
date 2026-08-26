import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/units/unit_model.dart';
import 'package:anyamar/views/pages/dashboard/properties_page/units/unit_forms/unit_form.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/units_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyUnits extends ConsumerStatefulWidget {
  final Property property;
  const PropertyUnits({super.key, required this.property});

  @override
  ConsumerState<PropertyUnits> createState() => _PropertyUnitsState();
}

class _PropertyUnitsState extends ConsumerState<PropertyUnits> {
  List<Unit> propertyUnits = [];
  List<Unit> filteredUnits = [];

  @override
  void initState() {
    super.initState();
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
    propertyUnits = ref
        .watch(userInformationProvider.select((state) => state.units))
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();

    filteredUnits = propertyUnits;
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
