import 'dart:ui';
import 'package:flutter/material.dart';

class DataLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final bool isDarkMode;

  const DataLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: (isDarkMode ? Colors.black : Colors.white).withValues(
                alpha: 0.25,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      width: 290,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF252F3D).withValues(alpha: 0.95)
                            : Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.12)
                              : const Color(0xFFDCE4EE),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              minHeight: 6,
                              backgroundColor: isDarkMode
                                  ? const Color(0xFF3A4658)
                                  : const Color(0xFFEAF1FA),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Getting things ready',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xFF253247),
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Please be patient while we load your data. '
                            'This should only take a moment.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  height: 1.5,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : const Color(0xFF667085),
                                ),
                          ),
                        ],
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
