import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/forms/add_property_form.dart';

class AddPropertyStatePage extends ConsumerWidget {
  const AddPropertyStatePage({super.key});

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
      pageTitle: 'Add Property',
      introRowWidgets: [],
      scrollableDashboardWidget: AddPropertyForm(),
    );
  }
}
