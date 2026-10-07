import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/views/pages/dashboard_views/dashboard_widgets/occupancy_widget/occupancy_gauge_painter.dart';
import 'package:google_fonts/google_fonts.dart';

class OccupancyCardWidget extends ConsumerWidget {
  const OccupancyCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appDataProvider);
    double occupacyPercentage = appData.occupiedUnitCount / appData.unitCount;
    final themeIsDark = ref.watch(themeIsDarkProvider);

    return DashboardCardWidget(
      cardTitle: 'Occupancy Rate',

      child: Column(
        children: [
          // Expanded(child: SizedBox()),
          SizedBox(
            height: 250,
            child: CustomPaint(
              painter: OccupancyGaugePainter(percentage: occupacyPercentage),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 55),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${occupacyPercentage * 100} %',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: themeIsDark == true
                              ? AppColors.whiteColor
                              : const Color(0xFF10203D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${appData.occupiedUnitCount} of ${appData.unitCount} units occupied',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: themeIsDark == true
                              ? AppColors.whiteColor
                              : const Color(0xFF39465A),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '${appData.vacantUnitCount} units vacant',
                        style: GoogleFonts.inter(
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
