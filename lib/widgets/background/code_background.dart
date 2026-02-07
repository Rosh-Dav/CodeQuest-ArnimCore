import 'dart:math';
import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import 'editor_grid_painter.dart';
import 'code_snippet_painter.dart';
import 'data_structure_painter.dart';

class CodeBackground extends StatefulWidget {
  const CodeBackground({super.key});

  @override
  State<CodeBackground> createState() => _CodeBackgroundState();
}

class _CodeBackgroundState extends State<CodeBackground> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  final List<CodeSnippet> _snippets = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(seconds: 30))
      ..repeat();

    _initSnippets();
  }

  void _initSnippets() {
    for (int i = 0; i < 20; i++) {
      _snippets.add(CodeSnippet(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        width: _random.nextDouble() * 100 + 50,
        opacity: _random.nextDouble() * 0.3 + 0.1,
        color: _random.nextBool() ? AppTheme.syntaxBlue : AppTheme.syntaxGreen,
        speed: _random.nextDouble() * 0.2 + 0.05,
      ));
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. IDE Theme Background
        Container(
          color: AppTheme.ideBackground,
        ),

        // 2. Editor Grid Overlay
        Opacity(
          opacity: 0.3,
          child: CustomPaint(
            painter: EditorGridPainter(_animController.value),
            size: Size.infinite,
          ),
        ),

        // 3. Floating Code Snippets
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return CustomPaint(
                painter: CodeSnippetPainter(
                  snippets: _snippets,
                  animationValue: _animController.value,
                ),
              );
            },
          ),
        ),

        // 4. Abstract Data Structures (Right side overlay)
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return CustomPaint(
                painter: DataStructurePainter(_animController.value),
              );
            },
          ),
        ),
        
        // 5. Vignette for focus
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [
                Colors.transparent,
                AppTheme.ideBackground.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
