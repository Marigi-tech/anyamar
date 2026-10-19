import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/methods/delete_item_function.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';

class TenantsTable extends ConsumerStatefulWidget {
  final List<Tenant>? tenants;
  final bool? hasTitle;
  final String introText;
  const TenantsTable({
    super.key,
    this.tenants,
    this.hasTitle = false,
    required this.introText,
  });

  @override
  ConsumerState<TenantsTable> createState() => _TenantsTableState();
}

class _TenantsTableState extends ConsumerState<TenantsTable> {
  String searchQuery = '';
  String propertyName = '';
  String unitName = '';
  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);
    final tenants = widget.tenants ?? appData.tenants;
    final properties = appData.properties;
    final units = appData.units;
    final TextStyle headerStyle = CustomTextStyles.cardDescriptionStyle
        .copyWith(
          color: themeIsDark == true
              ? AppColors.whiteColor
              : AppColors.blueGreyColor,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w200,
          letterSpacing: 0.6,
        );
    final TextStyle labelStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark == true ? AppColors.whiteColor : AppColors.lightText,
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.3,
    );

    return ReusableDataTableWidget<Tenant>(
      items: tenants,
      cardTitle: widget.hasTitle == true ? 'Tenants' : '',

      searchHint: 'Search ',

      columns: [
        DataColumn(label: SizedBox(width: 8, child: Text("#"))),
        DataColumn(label: Text("Full Name", style: headerStyle)),
        DataColumn(label: Text("Phone Number", style: headerStyle)),
        DataColumn(label: Text("Unit ", style: headerStyle)),
        DataColumn(label: Text('Property ', style: headerStyle)),
        DataColumn(label: Text("Actions", style: headerStyle)),
      ],

      // --------------------------------------------
      // SEARCH
      // --------------------------------------------
      searchMatcher: (tenant, query) {
        return tenant.tenantName.toLowerCase().contains(query) ||
            propertyName.toLowerCase().contains(query) ||
            unitName.toLowerCase().contains(query) ||
            tenant.tenantPhoneNumber.toString().toLowerCase().contains(query);
      },

      // --------------------------------------------
      // FILTER
      // --------------------------------------------
      onFilterPressed: () {
        // Show your property filter dialog
      },

      // --------------------------------------------
      // EXPORT
      // --------------------------------------------
      onExportPressed: () {
        // Export properties
      },

      // --------------------------------------------
      // ROW
      // --------------------------------------------
      rowBuilder: (tenant, index) {
        //Instance of Unit
        final unit = units.where((u) => u.unitId == tenant.unitId).singleOrNull;
        //Instance of property
        final property = properties
            .where((p) => p.propertyId == unit?.propertyId)
            .singleOrNull;

        propertyName = property?.propertyName ?? '';
        unitName = unit?.unitName ?? '';
        var number = index + 1;

        return DataRow(
          cells: [
            DataCell(SizedBox(width: 8, child: Text('${number++}'))),
            DataCell(
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color:
                            avatarBackgroundColors[index %
                                avatarBackgroundColors.length],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          getInitials(tenant.tenantName),
                          style: CustomTextStyles.cardExtraDescriptionStyle
                              .copyWith(
                                fontStyle: FontStyle.normal,
                                color: AppColors.whiteColor,
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tenant.tenantName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeIsDark == true
                              ? AppColors.whiteColor
                              : Color(0xff172554),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DataCell(Text('${tenant.tenantPhoneNumber}', style: labelStyle)),
            DataCell(Text(unitName, style: labelStyle)),
            DataCell(Text(propertyName, style: labelStyle)),
            DataCell(
              Row(
                children: [
                  IconButton(
                    tooltip: 'View',
                    onPressed: () {
                      // ref
                      //     .read(tenantPageProvider.notifier)
                      //     .viewTenantInformation(tenant);
                      ref
                          .read(workspaceProvider.notifier)
                          .openForm(
                            DashboardPageStructure(
                              introText: '${widget.introText} / tenant',
                              pageTitle: tenant.tenantName,
                              introRowWidgets: [],
                              introButton: IntroButtonWidget(),
                              scrollableDashboardWidget: SingleTenantPage(
                                tenant: tenant,
                                introText: '${widget.introText} / tenant',
                              ),
                            ),
                          );
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_right,
                      size: 15,
                      color: Color(0xff1769F5),
                    ),
                  ),

                  PopupMenuButton<String>(
                    tooltip: 'More',
                    icon: const Icon(Icons.more_vert, size: 18),
                    onSelected: (value) {
                      switch (value) {
                        case 'view':
                          ref
                              .read(workspaceProvider.notifier)
                              .openForm(
                                DashboardPageStructure(
                                  introText: '${widget.introText} / tenant',
                                  pageTitle: tenant.tenantName,
                                  introRowWidgets: [],
                                  introButton: IntroButtonWidget(),
                                  scrollableDashboardWidget: SingleTenantPage(
                                    tenant: tenant,
                                    introText: '${widget.introText} / tenant',
                                  ),
                                ),
                              );
                          break;

                        case 'edit':
                          ref
                              .read(workspaceProvider.notifier)
                              .openForm(
                                DashboardPageStructure(
                                  introText: '${widget.introText} / update tenant',
                                  pageTitle: tenant.tenantName,
                                  introRowWidgets: [],
                                  introButton: IntroButtonWidget(),
                                  scrollableDashboardWidget: TenantForm(
                                    currentTenant: tenant,
                                 
                                  ),
                                ),
                              );
                          break;

                        case 'delete':
                          deleteItemFunction(
                            context,
                            'tenant',
                            tenant.tenantName,
                            _deleteTenant(context, ref, tenant),
                          );
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'view',
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.eye, size: 18),
                            SizedBox(width: 10),
                            Text('View'),
                          ],
                        ),
                      ),

                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 10),
                            Text('Update'),
                          ],
                        ),
                      ),

                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18),
                            SizedBox(width: 10),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<void> _deleteTenant(
  BuildContext context,
  WidgetRef ref,
  Tenant tenant,
) async {
  final tenantDb = DbTenantService();

  await tenantDb.deleteTenantRecord(tenant);

  ref.read(userInformationProvider.notifier).removeProperty(tenant.tenantId);
}
