import 'package:flutter/material.dart';
import 'package:test_app/data/data_sets/tenants.dart';

import 'package:test_app/data/models/property_model.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/views/widgets/table_intro_widget/table_intro_widget.dart';
import 'package:test_app/views/widgets/tables/tenants_table.dart';

class PropertyTenants extends StatefulWidget {
  final Property property;
  const PropertyTenants({super.key, required this.property});

  @override
  State<PropertyTenants> createState() => _PropertyTenantsState();
}

class _PropertyTenantsState extends State<PropertyTenants> {
  List<Tenant> propertyTenants = [];
  List<Tenant> filteredTenants = [];

  @override
  void initState() {
    super.initState();

    propertyTenants = tenants
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();

    filteredTenants = propertyTenants;
  }

  void filterSingleTenantTableData(String query) {
    final search = query.toLowerCase();

    setState(() {
      filteredTenants = propertyTenants
          .where((t) => t.matchesTenantSearch(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        TableIntroWidget(
          dataLength: '${filteredTenants.length}',
          dataType: 'tenants',
          onSearch: filterSingleTenantTableData,
        ),

        SizedBox(height: 30),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
            child: TenantsTable(
              propertyTenants: filteredTenants,
              isUnitTenant: true,
            ),
          ),
        ),
      ],
    );
  }
}
