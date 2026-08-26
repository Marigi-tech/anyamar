import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/tenant_forms/tenant_form.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/tenants_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyTenants extends ConsumerStatefulWidget {
  final Property property;
  const PropertyTenants({super.key, required this.property});

  @override
  ConsumerState<PropertyTenants> createState() => _PropertyTenantsState();
}

class _PropertyTenantsState extends ConsumerState<PropertyTenants> {
  List<Tenant> propertyTenants = [];
  List<Tenant> filteredTenants = [];

  @override
  void initState() {
    super.initState();

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
    propertyTenants = ref
        .watch(userInformationProvider.select((state) => state.tenants))
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    filteredTenants = propertyTenants;

    return Column(
      children: [
        SizedBox(height: 20),
        TableIntroWidget(
          dataLength: '${filteredTenants.length}',
          dataType: 'tenants',
          onSearch: filterSingleTenantTableData,
          onPressedCallBack: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddTenant())),
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
