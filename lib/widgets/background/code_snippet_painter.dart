import 'package:flutter/material.dart';

class CodeSnippet {
  double x;
  double y;
  double width;
  double opacity;
  Color color;
  double speed;

  CodeSnippet({
    required this.x,
    required this.y,
    required this.width,
    required this.opacity,
    required this.color,
    required this.speed,
  });
}

class CodeSnippetPainter extends CustomPainter {
  final List<CodeSnippet> snippets;
  final double animationValue;

  CodeSnippetPainter({required this.snippets, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    for (var snippet in snippets) {
      // Simulate vertical scrolling (like reading code)
      double currentY = (snippet.y + animationValue * snippet.speed) % 1.0;
      double drawY = currentY * size.height;
      double drawX = snippet.x * size.width;

      paint.color = snippet.color.withValues(alpha: snippet.opacity);

      // Draw dashed line representing code
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(drawX, drawY, snippet.width, 4),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CodeSnippetPainter oldDelegate) => true;
}
