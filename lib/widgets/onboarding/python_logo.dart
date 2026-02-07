import 'package:flutter/material.dart';

class PythonLogo extends StatelessWidget {
  final double size;

  const PythonLogo({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: PythonLogoPainter(),
      ),
    );
  }
}

class PythonLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    
    // Python official colors
    final Paint bluePaint = Paint()
      ..color = const Color(0xFF3776AB)
      ..style = PaintingStyle.fill;
    
    final Paint yellowPaint = Paint()
      ..color = const Color(0xFFFFD43B)
      ..style = PaintingStyle.fill;
    
    final Paint whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw blue snake (top-left) - more accurate shape
    Path bluePath = Path();
    bluePath.moveTo(width * 0.25, height * 0.15);
    bluePath.cubicTo(
      width * 0.15, height * 0.15,
      width * 0.1, height * 0.2,
      width * 0.1, height * 0.3,
    );
    bluePath.lineTo(width * 0.1, height * 0.45);
    bluePath.cubicTo(
      width * 0.1, height * 0.48,
      width * 0.12, height * 0.5,
      width * 0.15, height * 0.5,
    );
    bluePath.lineTo(width * 0.45, height * 0.5);
    bluePath.lineTo(width * 0.45, height * 0.3);
    bluePath.cubicTo(
      width * 0.45, height * 0.2,
      width * 0.4, height * 0.15,
      width * 0.3, height * 0.15,
    );
    bluePath.lineTo(width * 0.25, height * 0.15);
    bluePath.close();
    canvas.drawPath(bluePath, bluePaint);

    // Draw yellow snake (bottom-right) - more accurate shape
    Path yellowPath = Path();
    yellowPath.moveTo(width * 0.75, height * 0.85);
    yellowPath.cubicTo(
      width * 0.85, height * 0.85,
      width * 0.9, height * 0.8,
      width * 0.9, height * 0.7,
    );
    yellowPath.lineTo(width * 0.9, height * 0.55);
    yellowPath.cubicTo(
      width * 0.9, height * 0.52,
      width * 0.88, height * 0.5,
      width * 0.85, height * 0.5,
    );
    yellowPath.lineTo(width * 0.55, height * 0.5);
    yellowPath.lineTo(width * 0.55, height * 0.7);
    yellowPath.cubicTo(
      width * 0.55, height * 0.8,
      width * 0.6, height * 0.85,
      width * 0.7, height * 0.85,
    );
    yellowPath.lineTo(width * 0.75, height * 0.85);
    yellowPath.close();
    canvas.drawPath(yellowPath, yellowPaint);

    // Draw white eyes
    canvas.drawCircle(
      Offset(width * 0.25, height * 0.25),
      width * 0.04,
      whitePaint,
    );
    canvas.drawCircle(
      Offset(width * 0.75, height * 0.75),
      width * 0.04,
      whitePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
