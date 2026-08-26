import 'package:anyamar/data/providers/user_information_provider.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_page_shell.dart';
import 'package:flutter/material.dart';
import 'package:anyamar/data/models/tenants/tenant_model.dart';
import 'package:anyamar/views/pages/dashboard/tenants_page/tenant_forms/tenant_form.dart';
import 'package:anyamar/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:anyamar/views/pages/dashboard/dashboard_tables/tenants_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TenantsPage extends ConsumerStatefulWidget {
  const TenantsPage({super.key});

  @override
  ConsumerState<TenantsPage> createState() => _TenantsPageState();
}

class _TenantsPageState extends ConsumerState<TenantsPage> {
  List<Tenant> propertyTenants = [];
  List<Tenant> filteredTenants = [];

  @override
  Widget build(BuildContext context) {
    propertyTenants = ref.watch(
      userInformationProvider.select((state) => state.tenants),
    );
    filteredTenants = propertyTenants;
    void filterSingleTenantTableData(String query) {
      final search = query.toLowerCase();

      setState(() {
        filteredTenants = propertyTenants
            .where((t) => t.matchesTenantSearch(search))
            .toList();
      });
    }

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
