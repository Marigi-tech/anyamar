import 'package:anyamar/commons/exports.dart';

class PropertyTenants extends ConsumerStatefulWidget {
  final Property property;
  final String introText;
  const PropertyTenants({
    super.key,
    required this.property,
    required this.introText,
  });

  @override
  ConsumerState<PropertyTenants> createState() => _PropertyTenantsState();
}

class _PropertyTenantsState extends ConsumerState<PropertyTenants> {
  @override
  Widget build(BuildContext context) {
    final appData = ref.watch(userInformationProvider);
    //units
    final propertyUnits = appData.units
        .where((element) => element.propertyId == widget.property.propertyId)
        .toList();
    //tenants
    final propertyTenants = appData.tenants
        .where(
          (tenant) => propertyUnits.any((unit) => unit.unitId == tenant.unitId),
        )
        .toList();

    return TenantsTable(
      tenants: propertyTenants,
      hasTitle: true,
      introText: widget.introText,
    );
  }
}
