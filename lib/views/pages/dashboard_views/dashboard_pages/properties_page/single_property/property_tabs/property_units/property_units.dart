import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/tables/units_table.dart';

class PropertyUnits extends ConsumerStatefulWidget {
  final Property property;
  final String introText;
  const PropertyUnits({
    super.key,
    required this.property,
    required this.introText,
  });

  @override
  ConsumerState<PropertyUnits> createState() => _PropertyUnitsState();
}

class _PropertyUnitsState extends ConsumerState<PropertyUnits> {
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(userInformationProvider);
    final propertyUnits = appData.units
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    return UnitsTable(
      units: propertyUnits,
      hasTitle: true,
      introText: widget.introText,
    );
  }
}
