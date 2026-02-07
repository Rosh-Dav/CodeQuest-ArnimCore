import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';
import '../widgets/background/code_snippet_painter.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  final List<CodeSnippet> _snippets = [];
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _initSnippets();
    _startProgress();
  }

  void _initSnippets() {
    final snippets = [
      CodeSnippet(x: 0.1, y: 0.2, width: 80, opacity: 0.3, color: AppTheme.syntaxBlue, speed: 0.1),
      CodeSnippet(x: 0.7, y: 0.4, width: 100, opacity: 0.2, color: AppTheme.syntaxGreen, speed: 0.15),
      CodeSnippet(x: 0.3, y: 0.6, width: 60, opacity: 0.25, color: AppTheme.syntaxYellow, speed: 0.12),
      CodeSnippet(x: 0.8, y: 0.1, width: 90, opacity: 0.2, color: AppTheme.syntaxPurple, speed: 0.08),
    ];
    _snippets.addAll(snippets);
  }

  void _startProgress() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      setState(() {
        _progress += 0.02;
      });

      if (_progress >= 1.0) {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ideBackground,
      body: Stack(
        children: [
          // Animated Background
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

          // Center Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Title
                Text(
                  'CodeQuest',
                  style: AppTheme.headingStyle.copyWith(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.3, end: 0),

                const SizedBox(height: 16),

                // Tagline
                Text(
                  '// Master the art of coding',
                  style: AppTheme.codeStyle.copyWith(
                    color: AppTheme.syntaxComment,
                    fontSize: 16,
                  ),
                ).animate(delay: 300.ms)
                  .fadeIn(duration: 600.ms),

                const SizedBox(height: 60),

                // Progress Bar
                Container(
                  width: 300,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.idePanel,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        width: 300 * _progress,
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppTheme.syntaxBlue, AppTheme.syntaxGreen],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 600.ms)
                  .fadeIn(duration: 400.ms),

                const SizedBox(height: 16),

                // Loading Text
                Text(
                  'Compiling workspace...',
                  style: AppTheme.codeStyle.copyWith(
                    color: AppTheme.syntaxComment,
                    fontSize: 12,
                  ),
                ).animate(delay: 800.ms)
                  .fadeIn(duration: 400.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
