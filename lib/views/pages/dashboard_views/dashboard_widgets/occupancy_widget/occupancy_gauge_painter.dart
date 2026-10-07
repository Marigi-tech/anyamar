import 'dart:math' as math;

import 'package:anyamar/commons/exports.dart';

class OccupancyGaugePainter extends CustomPainter {
  final double percentage;

  OccupancyGaugePainter({
    required this.percentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height * .63,
    );

    final radius =
        math.min(size.width / 2, size.height) - 25;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 21
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFE0E4E9);

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 21
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF2469DB);

    const startAngle = math.pi;
    const totalSweep = math.pi;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      startAngle,
      totalSweep,
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      startAngle,
      totalSweep * percentage,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant OccupancyGaugePainter oldDelegate,
  ) {
    return oldDelegate.percentage != percentage;
  }
}