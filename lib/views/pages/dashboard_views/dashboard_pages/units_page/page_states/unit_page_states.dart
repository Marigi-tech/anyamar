import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/unavailable_info/unavailable_info_model.dart';
//=====================================================
//ADD UNIT
//========================================================

class AddUnitState extends ConsumerWidget {
  final String introText;

  const AddUnitState({super.key, required this.introText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    List<Property> allProperties = appData.properties;

    return DashboardPageStructure(
      introText: '$introText / add unit',
      pageTitle: 'Add unit',
      introRowWidgets: [],
      introButton: IntroButtonWidget(),
      scrollableDashboardWidget: AddOrUpdateUnitForm(
        introText: '$introText / add unit',
      ),
      unavailableInfo: allProperties.isEmpty
          ? UnavailableInfoModel(
              text: 'Sorry, ${appData.appUser?.userName}',
              supplementaryText:
                  'There are no properties at the moment, add a property to the system , then add units to those properties',
              closeMethod: () =>
                  ref.read(workspaceProvider.notifier).closeWorkspace(),
              ctaButtonWidget: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButtonWidget(
                    buttonTitle: 'Close',
                    isClear: true,
                    onButtonPressedCallBack: () =>
                        ref.read(workspaceProvider.notifier).closeWorkspace(),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

//=====================================================
//UPDATE UNIT
//========================================================

class UpdateUnitState extends ConsumerWidget {
  final String introText;
  final Unit unit;

  const UpdateUnitState({
    super.key,
    required this.introText,
    required this.unit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DashboardPageStructure(
      introText: '$introText / update unit',
      pageTitle: unit.unitName,
      introRowWidgets: [],
      introButton: IntroButtonWidget(),
      scrollableDashboardWidget: AddOrUpdateUnitForm(
        unit: unit,
        introText: '$introText / update unit',
      ),
    );
  }
}
