import 'package:anyamar/commons/exports.dart';

import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/occupancy_widget/occupancy_gauge_painter.dart';

class OccupancyCardWidget extends ConsumerWidget {
  const OccupancyCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(userInformationProvider);
    double occupancyPercentage =
        appData.occupiedUnitCount > 0 && (appData.unitCount > 0)
        ? appData.occupiedUnitCount / appData.unitCount
        : 0;
    final themeIsDark = ref.watch(themeIsDarkProvider);

    return DashboardCardWidget(
      cardTitle: 'Occupancy Rate',
      child: Column(
        children: [
          // Expanded(child: SizedBox()),
          SizedBox(
            height: 250,
            child: CustomPaint(
              painter: OccupancyGaugePainter(percentage: occupancyPercentage),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 55),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(occupancyPercentage * 100).toStringAsFixed(0)} %',
                        style: AppTextStylesConstant.cardDescriptionStyle
                            .copyWith(
                              fontSize: 28,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              color: themeIsDark == true
                                  ? AppColors.whiteColor
                                  : const Color(0xFF10203D),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${appData.occupiedUnitCount} of ${appData.unitCount} units occupied',
                        style: AppTextStylesConstant.cardDescriptionStyle
                            .copyWith(
                              fontSize: 11,
                              fontStyle: FontStyle.normal,
                              color: themeIsDark == true
                                  ? AppColors.whiteColor
                                  : const Color(0xFF39465A),
                            ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '${appData.vacantUnitCount} units vacant',
                        style: AppTextStylesConstant.cardDescriptionStyle
                            .copyWith(
                              fontSize: 10,
                              color: themeIsDark == true
                                  ? AppColors.whiteColor
                                  : const Color(0xFF778195),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
