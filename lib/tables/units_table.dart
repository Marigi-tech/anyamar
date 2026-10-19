import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/methods/delete_item_function.dart';
import 'package:anyamar/data/providers/workspace/workspace_notifier.dart';

class UnitsTable extends ConsumerStatefulWidget {
  final List<Unit>? units;
  final bool? hasTitle;
  final String introText;
  const UnitsTable({
    super.key,
    this.units,
    this.hasTitle = false,
    required this.introText,
  });

  @override
  ConsumerState<UnitsTable> createState() => _UnitsTableState();
}

class _UnitsTableState extends ConsumerState<UnitsTable> {
  List<Unit> units = [];
  List<Tenant> tenants = [];
  List<Property> properties = [];

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(userInformationProvider);
    properties = appData.properties;
    units = widget.units ?? units;
    final headerStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark ? AppColors.whiteColor : AppColors.blueGreyColor,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w200,
      letterSpacing: 0.6,
      fontSize: 14,
    );

    final labelStyle = CustomTextStyles.cardDescriptionStyle.copyWith(
      color: themeIsDark ? AppColors.whiteColor : AppColors.lightText,
      fontStyle: FontStyle.normal,
      fontSize: 13,
      letterSpacing: 0.3,
    );

    return ReusableDataTableWidget<Unit>(
      items: units,
      cardTitle: widget.hasTitle == true ? 'Units' : '',
      searchHint: 'Search units...',

      columns: [
        DataColumn(
          label: SizedBox(width: 7, child: Text('#', style: headerStyle)),
        ),
        DataColumn(label: Text('Unit name', style: headerStyle)),
        DataColumn(label: Text('Property', style: headerStyle)),
        DataColumn(label: Text('Unit Type', style: headerStyle)),
        DataColumn(label: Text('Rent', style: headerStyle)),
        DataColumn(label: Text('Status', style: headerStyle)),
        DataColumn(label: Text('Actions', style: headerStyle)),
      ],
      searchMatcher: (unit, query) {
        final property = properties
            .where((p) => p.propertyId == unit.propertyId)
            .firstOrNull;

        final tenant = tenants
            .where((t) => t.unitId == unit.unitId)
            .firstOrNull;

        return unit.unitName.toLowerCase().contains(query) ||
            (property?.propertyName ?? '').toLowerCase().contains(query) ||
            (tenant?.tenantName ?? '').toLowerCase().contains(query);
      },

      onFilterPressed: () {
        // Show filter
      },

      onExportPressed: () {
        // Export
      },

      rowBuilder: (unit, index) {
        // final tenant = tenants
        //     .where((tenant) => tenant.unitId == unit.unitId)
        //     .firstOrNull;

        final property = properties
            .where((property) => property.propertyId == unit.propertyId)
            .firstOrNull;

        return DataRow(
          cells: [
            DataCell(
              SizedBox(
                width: 8,
                child: Text('${index + 1}', style: labelStyle),
              ),
            ),

            DataCell(Text(unit.unitName, style: labelStyle)),

            DataCell(Text(property?.propertyName ?? '', style: labelStyle)),

            DataCell(Text(unit.unitType?.label ?? '', style: labelStyle)),

            DataCell(
              Text(
                '${unit.unitRent?.rentCurrency ?? 'Ksh'} '
                '${unit.unitRent?.rentAmount != null ? formatMoney(unit.unitRent!.rentAmount) : '0.00'}',
                style: labelStyle,
              ),
            ),

            DataCell(UnitVacancyBadge(isOccupied: unit.isOccupied)),

            DataCell(
              Row(
                children: [
                  IconButton(
                    tooltip: 'View',
                    onPressed: () {
                      ref
                          .read(workspaceProvider.notifier)
                          .openForm(
                            DashboardPageStructure(
                              introText: '${widget.introText} / unit',
                              pageTitle: unit.unitName,
                              introRowWidgets: [],
                              introButton: IntroButtonWidget(),
                              scrollableDashboardWidget: SingleUnitWidget(
                                unit: unit,
                                introText: '${widget.introText} / unit',
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
                                  introText: '${widget.introText} / unit',
                                  pageTitle: unit.unitName,
                                  introRowWidgets: [],
                                  introButton: IntroButtonWidget(),
                                  scrollableDashboardWidget: SingleUnitWidget(
                                    unit: unit,
                                    introText: '${widget.introText} / unit',
                                  ),
                                ),
                              );
                          break;

                        case 'edit':
                          ref
                              .read(workspaceProvider.notifier)
                              .openForm(
                                DashboardPageStructure(
                                  introText:
                                      '${widget.introText} / update unit',
                                  pageTitle: unit.unitName,
                                  introRowWidgets: [],
                                  introButton: IntroButtonWidget(),
                                  scrollableDashboardWidget:
                                      AddOrUpdateUnitForm(unit: unit),
                                ),
                              );
                          break;

                        case 'delete':
                          deleteItemFunction(
                            context,
                            'unit',
                            unit.unitName,
                            _deleteUnit(context, ref, unit),
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
                            Text(' Update'),
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

  Future<void> _deleteUnit(
    BuildContext context,
    WidgetRef ref,
    Unit unit,
  ) async {
    final unitDb = DbUnitsService();

    await unitDb.deleteUnitRecord(unit);

    ref.read(userInformationProvider.notifier).removeUnit(unit.unitId);
  }
}
