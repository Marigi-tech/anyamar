import 'package:flutter/material.dart';
import 'package:test_app/data/data_sets/tenants.dart';
import 'package:test_app/data/models/tenant_model.dart';
import 'package:test_app/views/dashboard_widgets/intro_text_widget.dart';
import 'package:test_app/views/forms/tenant_forms/tenant_form.dart';
import 'package:test_app/views/reusable_widgets/table_intro_widget/table_intro_widget.dart';
import 'package:test_app/views/tables/tenants_table.dart';

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
            // --- HEADER (Flex: 1) ---
            // Replaced Expanded(flex: 1, ...) with SizedBox(height: headerHeight, ...)
            SizedBox(
              height: headerHeight,
              child: IntroTextWidget(dashboardItem: 'Tenants'),
            ),

            // --- SCROLLABLE TABLE (Flex: 8) ---
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
                        padding: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 30.0,
                        ),

                        child: TenantsTable(
                          isUnitTenant: false,
                          propertyTenants: filteredTenants,
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
