import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class EditorGridPainter extends CustomPainter {
  final double animationValue;

  EditorGridPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = AppTheme.glassBorder.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    final double gridSize = 40.0;
    
    // Vertical lines (like indentation guides)
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }

    // Horizontal lines (like line numbers rows)
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant EditorGridPainter oldDelegate) => false;
}
