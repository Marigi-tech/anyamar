//================================================================
// ADD PROPERTY STATE
//================================================================

import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/forms/add_property_form.dart';

class AddPropertyState extends ConsumerWidget {
  final String introText;

  const AddPropertyState({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: '$introText / add property',
      pageTitle: 'Add property',
      introRowWidgets: [],
      introButton: const IntroButtonWidget(),
      scrollableDashboardWidget: AddPropertyForm(
        introText: '$introText / add property',
      ),
    );
  }
}
//=====================================================
// UPDATE PROPERTY
//========================================================

class UpdatePropertyState extends ConsumerWidget {
  final String introText;
  final Property property;

  const UpdatePropertyState({
    super.key,
    required this.introText,
    required this.property,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    List<Unit> propertyUnits = appData.units
        .where((unit) => unit.propertyId == property.propertyId)
        .toList();
    return DashboardPageStructure(
      introText: '$introText / update property',
      pageTitle: property.propertyName,
      supplementaryText:
          'Location: ${property.propertyLocation} | Units : ${propertyUnits.length} ',
      introRowWidgets: [],
      introButton: IntroButtonWidget(),
      scrollableDashboardWidget: AddPropertyForm(
        introText: '$introText / update property',
        currentProperty: property,
      ),
    );
  }
}
