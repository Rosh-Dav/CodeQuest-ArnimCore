import 'dart:math';
import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class DataStructurePainter extends CustomPainter {
  final double animationValue;

  DataStructurePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppTheme.syntaxPurple.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint nodePaint = Paint()
      ..color = AppTheme.syntaxBlue.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    // Draw a gentle binary tree structure on the right side
    _drawTree(
      canvas, 
      Offset(size.width * 0.85, size.height * 0.2), 
      60, 
      0, 
      paint, 
      nodePaint,
      3
    );
  }

  void _drawTree(Canvas canvas, Offset pos, double branchLen, double angle, Paint linePaint, Paint nodePaint, int depth) {
    if (depth == 0) return;

    // Draw node
    canvas.drawCircle(pos, 6, nodePaint);

    // Left branch
    double angle1 = angle + pi / 4 + (sin(animationValue * 2) * 0.05);
    Offset nextPos1 = Offset(
      pos.dx - cos(angle1) * branchLen,
      pos.dy + sin(angle1) * branchLen,
    );
    canvas.drawLine(pos, nextPos1, linePaint);
    _drawTree(canvas, nextPos1, branchLen * 0.8, angle, linePaint, nodePaint, depth - 1);

    // Right branch
    double angle2 = angle - pi / 4 - (sin(animationValue * 2 + 1) * 0.05);
    Offset nextPos2 = Offset(
      pos.dx + cos(angle2) * branchLen,
      pos.dy + sin(angle2) * branchLen,
    );
    canvas.drawLine(pos, nextPos2, linePaint);
    _drawTree(canvas, nextPos2, branchLen * 0.8, angle, linePaint, nodePaint, depth - 1);
  }

  @override
  bool shouldRepaint(covariant DataStructurePainter oldDelegate) => true;
}
