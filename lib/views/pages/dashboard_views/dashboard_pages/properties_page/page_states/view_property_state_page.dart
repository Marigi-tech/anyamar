import 'package:anyamar/commons/exports.dart';

class ViewPropertyStatePage extends ConsumerWidget {
  final Property property;
  const ViewPropertyStatePage({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: 'Properties',
      pageTitle: property.propertyName.toUpperCase(),
      supplementaryText:
          '${property.propertyFloors != 0 ? '${property.propertyFloors} Floors' : ''} '
          '${property.propertyLocation}',
      introButton: IntroButtonWidget(
        buttonText: 'Back to properties',
        onPressedCallBack: () {
          ref.read(propertyPageProvider.notifier).showProperty(property);
        },
      ),
      introRowWidgets: [
        ElevatedButtonWidget(
          buttonTitle: 'Update Property',
          buttonIcon: const Icon(CupertinoIcons.pencil),
          onButtonPressedCallBack: () {
            ref
                .read(propertyPageProvider.notifier)
                .showUpdateProperty(property);
          },
        ),
      ],
      scrollableDashboardWidget: SinglePropertyPage(property: property),
    );
  }
}
