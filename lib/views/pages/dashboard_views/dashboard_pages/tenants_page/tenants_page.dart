import 'package:anyamar/data/models/properties/property_model.dart';
import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/custom_data_table.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/dashboard_page_shell.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/forms/tenant_form.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_tables/tenants_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TenantsPage extends ConsumerStatefulWidget {
  const TenantsPage({super.key});

  @override
  ConsumerState<TenantsPage> createState() => _TenantsPageState();
}

class _TenantsPageState extends ConsumerState<TenantsPage> {
  List<Tenant> myTenants = [];
  List<Tenant> filteredTenants = [];
  List<Property> myProperties = [];
  String searchQuery = '';

  void filterSingleTenantTableData(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  List<Tenant> getFilteredTenants(List<Tenant> currentTenants) {
    if (searchQuery.isEmpty) {
      return currentTenants;
    }
    return currentTenants
        .where(
          (tenant) => tenant.matchesTenantSearch(searchQuery, myProperties),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    myTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );

    myProperties = ref.watch(
      userInformationProvider.select((state) => state.properties),
    );

    filteredTenants = getFilteredTenants(myTenants);

    return DashboardPageShell(
      introText: 'Tenants',
      stickyWidget: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 20, top: 20),
        child: TableIntroWidget(
          dataLength: '${filteredTenants.length}',
          dataType: 'tenants',
          hasSearchBar: true,
          onSearch: filterSingleTenantTableData,
          onPressedCallBack: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddTenant())),
        ),
      ),
      dashboardWidgets: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: CustomDataTable(
            customDataColumns: [...buildTenantHeaderRows(false, false)],
            customDataRows: [
              ...filteredTenants.asMap().entries.map((entry) {
                final index = entry.key;
                final tenant = entry.value;

                final propertyName = myProperties
                    .firstWhere(
                      (element) => element.propertyId == tenant.propertyId,
                    )
                    .propertyName;

                return buildTenantDataRow(
                  index + 1,
                  tenant,
                  context,
                  propertyName,
                  ref,
                  false,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
