import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/custom_data_table.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/forms/tenant_form.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/tenants_table.dart';
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
  List<Property> myProperties = [];
  String searchQuery = '';

  void filterSingleTenantTableData(String query) {
    setState(() {
      searchQuery = query.trim().toLowerCase();
    });
  }

  List<Tenant> getFilteredPropertyTenants(List<Tenant> currentTenants) {
    if (searchQuery.isEmpty) {
      return filteredTenants = currentTenants;
    } else {
      return filteredTenants = currentTenants
          .where(
            (tenant) => tenant.matchesTenantSearch(searchQuery, myProperties),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    propertyTenants = ref
        .watch(userInformationProvider.select((state) => state.tenants))
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );

    filteredTenants = getFilteredPropertyTenants(propertyTenants);

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
            child: CustomDataTable(
              customDataColumns: [...buildTenantHeaderRows(true, true)],
              customDataRows: [
                ...filteredTenants.toList().asMap().entries.map((entry) {
                  int index = entry.key;
                  Tenant tenant = entry.value;

                  return buildTenantDataRow(
                    index + 1,
                    tenant,
                    context,
                    null,
                    ref,
                    null,
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
