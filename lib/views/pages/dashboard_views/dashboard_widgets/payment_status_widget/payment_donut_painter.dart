import 'dart:math' as math;

import 'package:anyamar/commons/exports.dart';

class PaymentDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = math.min(size.width, size.height) / 2 - 10;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 21
      ..strokeCap = StrokeCap.butt;

    final values = [.70, .10, .13, .07];

    final colors = [
      const Color(0xFF2DB65B),
      const Color(0xFFECA018),
      const Color(0xFFEF4B4B),
      const Color(0xFFADB3BC),
    ];

    double startAngle = -math.pi / 2;

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = values[i] * math.pi * 2;

      paint.color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
