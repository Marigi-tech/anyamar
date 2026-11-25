import 'package:anyamar/commons/exports.dart';
import 'package:anyamar/data/models/unavailable_info/unavailable_info_model.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

//===========================================================
// INFO UNAVAILABLE OVERLAY
//===========================================================
class InfoUnavailableOverlay extends ConsumerWidget {
  final Widget child;
  final UnavailableInfoModel? unavailableInfo;
  final bool? isError;
  final String? customLottiePath;

  const InfoUnavailableOverlay({
    super.key,
    this.unavailableInfo,
    required this.child,
    this.isError,
    this.customLottiePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeIsDarkProvider);
    return Stack(
      children: [
        child,
        if (unavailableInfo != null)
          Positioned.fill(
            child: ColoredBox(
              // Stronger film makes the form recede into the background.
              color: (isDarkMode ? Colors.black : const Color(0xFF253247))
                  .withValues(alpha: 0.40),

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),

                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        // width: 290,
                        width: MediaQuery.sizeOf(context).width < 400
                            ? 280
                            : 320,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          // Nearly opaque card so its content stays crisp.
                          color: isDarkMode
                              ? const Color(0xFF202B3A)
                              : Colors.white,

                          borderRadius: BorderRadius.circular(22),

                          border: Border.all(
                            color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.18)
                                : const Color(0xFFD5DEEA),
                            width: 1.2,
                          ),

                          boxShadow: [
                            // Main shadow lifts the popup away from the form.
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.22),
                              blurRadius: 36,
                              spreadRadius: 2,
                              offset: const Offset(0, 16),
                            ),

                            // Subtle outline glow separates the card's edges.
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.white.withValues(alpha: 0.035)
                                  : Colors.white.withValues(alpha: 0.8),
                              blurRadius: 1,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //* Close Icon
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                tooltip: 'Close',
                                onPressed: unavailableInfo!.closeMethod,
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : const Color(0xFF667085),
                                ),
                              ),
                            ),

                            //! Lottie Animation
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Lottie.asset(
                                customLottiePath ??
                                    (isError != true
                                        ? 'assets/lotties/login.json'
                                        : 'assets/lotties/help.json'),
                              ),
                            ),
                            const SizedBox(height: 10),

                            //? Information Title
                            Text(
                              unavailableInfo!.text,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xFF253247),
                                  ),
                            ),
                            const SizedBox(height: 3),
                            Container(
                              width: 60,
                              height: 2,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 4, 73, 221),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Supplementary text
                            Text(
                              unavailableInfo!.supplementaryText,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    height: 1.5,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : const Color(0xFF667085),
                                  ),
                            ),
                            const SizedBox(height: 35),
                            unavailableInfo!.ctaButtonWidget,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
