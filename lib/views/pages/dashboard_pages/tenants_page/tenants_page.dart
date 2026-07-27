import 'package:anyamar/views/pages/dashboard_pages/dashboard_page_shell.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/data_sets/tenants.dart';
import 'package:anyamar/data/models/tenant_model.dart';
import 'package:anyamar/views/forms/tenant_forms/tenant_form.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/tables/tenants_table.dart';

class TenantsPage extends StatefulWidget {
  const TenantsPage({super.key});

  @override
  State<TenantsPage> createState() => _TenantsPageState();
}

class _TenantsPageState extends State<TenantsPage> {
  List<Tenant> propertyTenants = [];
  List<Tenant> filteredTenants = [];

  @override
  void initState() {
    super.initState();

    propertyTenants = tenants.toList();

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
    return DashboardPageShell(
      introText: 'Tenants',
      stickyWidget: //Search bar
      Padding(
        padding: EdgeInsets.only(left: 10, bottom: 20, top: 20),
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

          child: TenantsTable(
            isUnitTenant: false,
            propertyTenants: filteredTenants,
          ),
        ),
      ],
    );
  }
}
