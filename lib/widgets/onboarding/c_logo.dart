import 'package:flutter/material.dart';
import 'dart:math' as math;

class CLogo extends StatelessWidget {
  final double size;

  const CLogo({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: CLogoPainter(),
      ),
    );
  }
}

class CLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final Offset center = Offset(width / 2, height / 2);
    final double radius = width * 0.42;

    // Shadow
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    Path shadowPath = Path();
    for (int i = 0; i < 6; i++) {
      double angle = (math.pi / 3) * i - math.pi / 2;
      double x = center.dx + (radius + 2) * math.cos(angle);
      double y = center.dy + (radius + 2) * math.sin(angle) + 4;
      if (i == 0) {
        shadowPath.moveTo(x, y);
      } else {
        shadowPath.lineTo(x, y);
      }
    }
    shadowPath.close();
    canvas.drawPath(shadowPath, shadowPaint);

    // C language blue gradient hexagon
    final Paint hexagonPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF659AD2),
          const Color(0xFF00599C),
        ],
      ).createShader(Rect.fromLTWH(0, 0, width, height))
      ..style = PaintingStyle.fill;

    // Draw hexagon
    Path hexPath = Path();
    for (int i = 0; i < 6; i++) {
      double angle = (math.pi / 3) * i - math.pi / 2;
      double x = center.dx + radius * math.cos(angle);
      double y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        hexPath.moveTo(x, y);
      } else {
        hexPath.lineTo(x, y);
      }
    }
    hexPath.close();
    canvas.drawPath(hexPath, hexagonPaint);

    // Draw white 'C' letter with better styling
    final Paint cPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * 0.15
      ..strokeCap = StrokeCap.round;

    Path cPath = Path();
    cPath.addArc(
      Rect.fromCircle(center: center, radius: radius * 0.45),
      math.pi * 0.65,
      math.pi * 1.7,
    );
    canvas.drawPath(cPath, cPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
