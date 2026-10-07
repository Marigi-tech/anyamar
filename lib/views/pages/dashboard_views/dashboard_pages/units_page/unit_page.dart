import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/providers/page_providers/unit_pages/unit_page_notifier.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_pages/units_page/units_table.dart';

sealed class UnitPageState {
  const UnitPageState();
}

class UnitsTablePageState extends UnitPageState {
  const UnitsTablePageState();
}

class AddUnitPageState extends UnitPageState {
  final Property? currentProperty;
  const AddUnitPageState({this.currentProperty});
}

class ViewUnitPageState extends UnitPageState {
  final Unit unit;
  final Property? property;

  const ViewUnitPageState({required this.unit, this.property});
}

class EditUnitPageState extends UnitPageState {
  final Unit unit;
  final Property? property;

  const EditUnitPageState({required this.unit, this.property});
}

class UnitsPage extends ConsumerStatefulWidget {
  const UnitsPage({super.key});

  @override
  ConsumerState<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends ConsumerState<UnitsPage> {
  String searchQuery = '';
  String tenantName = '';
  String propertyName = '';
  Unit? currentUnit;
  Property? currentUnitProperty;

  @override
  Widget build(BuildContext context) {
    final themeIsDark = ref.watch(themeIsDarkProvider);
    final appData = ref.watch(appDataProvider);
    final tenants = appData.tenants;
    final properties = appData.properties;
    final units = appData.units;
    final unitPageState = ref.watch(unitPageProvider);
    return switch (unitPageState) {
      UnitsTablePageState() => buildUnitsTable(
        context,
        ref,
        units,
        tenants,
        properties,
        themeIsDark,
      ),

      AddUnitPageState(:final currentProperty) => DashboardPageStructure(
        introText: 'Units',
        introButton: IntroButtonWidget(
          buttonText: 'Back to units',
          onPressedCallBack: () {
            ref.read(unitPageProvider.notifier).showUnits();
          },
        ),
        pageTitle: 'Add Unit',
        introRowWidgets: [],
        scrollableDashboardWidget: AddOrUpdateUnitForm(
          currentProperty: currentProperty,
        ),
      ),

      ViewUnitPageState(:final unit, :final property) => DashboardPageStructure(
        introText: 'Units',
        pageTitle: unit.unitName.toUpperCase(),
        supplementaryText:
            '${unit.floorNumber != null ? '${unit.floorNumber} Floor' : ''} '
            '${property?.propertyName ?? ''}',
        introButton: IntroButtonWidget(
          buttonText: 'Back to units',
          onPressedCallBack: () {
            ref.read(unitPageProvider.notifier).showUnits();
          },
        ),
        introRowWidgets: [
          ElevatedButtonWidget(
            buttonTitle: 'Update Unit',
            buttonIcon: const Icon(CupertinoIcons.pencil),
            onButtonPressedCallBack: () {
              ref
                  .read(unitPageProvider.notifier)
                  .showEditUnit(unit, property: property);
            },
          ),
        ],
        scrollableDashboardWidget: SingleUnitWidget(unit: unit),
      ),

      EditUnitPageState(:final unit, :final property) => DashboardPageStructure(
        introText: 'Units',
        introButton: IntroButtonWidget(
          buttonText: 'Back to units',
          onPressedCallBack: () {
            ref.read(unitPageProvider.notifier).showUnits();
          },
        ),
        pageTitle: 'Update Unit ${unit.unitName}',
        introRowWidgets: [],
        scrollableDashboardWidget: AddOrUpdateUnitForm(
          unit: unit,
          currentProperty: property,
        ),
      ),
    };
  }
}
