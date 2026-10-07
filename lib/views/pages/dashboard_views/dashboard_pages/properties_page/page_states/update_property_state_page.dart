import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/forms/add_property_form.dart';

class UpdatePropertyStatePage extends ConsumerWidget {
  final Property property;
  const UpdatePropertyStatePage({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Properties',
      introButton: IntroButtonWidget(
        buttonText: 'Back to properties',
        onPressedCallBack: () {
          ref.read(propertyPageProvider.notifier).showProperties();
        },
      ),
      pageTitle: 'Update Property ${property.propertyName}',
      introRowWidgets: [],
      scrollableDashboardWidget: AddPropertyForm(currentProperty: property),
    );
  }
}
