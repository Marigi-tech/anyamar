import 'package:anyamar/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LazyLoader {
  final OverlayState? _overlayState;
  OverlayEntry? _entry;

  bool _isLoaderVisible = false;

  LazyLoader({required BuildContext context})
    : _overlayState = Overlay.of(context);

  showLoader() {
    _entry = _loaderEntry();
    if (_entry != null && !_isLoaderVisible) {
      _overlayState?.insert(_entry!);
      _isLoaderVisible = true;
    }
  }

  hideLoader() {
    if (_entry != null && _isLoaderVisible) {
      _entry!.remove();
    }
  }

  OverlayEntry _loaderEntry() {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: AppColorsConstant.kBlack1.withValues(alpha: 0.6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF1A1A3F),
              rightDotColor: AppColorsConstant.greenColor,
              // rightDotColor: const Color(0xFFEA3799),
              size: 45,
            ),
          ],
        ),
        // child: const SpinKitFadingCircle(
        //   color: kBlue2,
        //   size: 55.0,
        // ),
      ),
    );

    return overlayEntry;
  }
}
