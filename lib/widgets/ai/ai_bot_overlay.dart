import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../utils/theme.dart';

class AIBotOverlay extends StatefulWidget {
  const AIBotOverlay({super.key});

  @override
  State<AIBotOverlay> createState() => _AIBotOverlayState();
}

class _AIBotOverlayState extends State<AIBotOverlay> {
  bool _showText = false;
  bool _showButton = false;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initSequence();
  }

  Future<void> _initSequence() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _showText = true);
    
    // Configure voice for a friendly assistant vibe
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0); // Normal pitch
    await _flutterTts.setSpeechRate(0.5); // Slightly slower for clarity
    
    await _speak("Workspace initialized. Ready to start your coding journey?");
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 30, // Bottom right corner like a chat assistant
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chat Bubble
          if (_showText)
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.idePanel,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(4),
                ),
                border: Border.all(color: AppTheme.syntaxBlue),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: DefaultTextStyle(
                style: AppTheme.codeStyle.copyWith(color: AppTheme.syntaxGreen),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '// System ready...\n// Welcome to CodeQuest!',
                      speed: const Duration(milliseconds: 50),
                    ),
                    TypewriterAnimatedText(
                      '// Let\'s debug your skills.\nawait startLearning();',
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  onFinished: () {
                    if (mounted) setState(() => _showButton = true);
                  },
                  isRepeatingAnimation: false,
                ),
              ),
            ).animate().scale(alignment: Alignment.bottomRight, curve: Curves.easeOutBack),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_showButton)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {}, // Navigate to Dashboard
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.syntaxBlue,
                        foregroundColor: AppTheme.ideBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Execute"),
                    ),
                  ).animate().fadeIn().slideX(),
                ),

              // Friendly Avatar Orb
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppTheme.syntaxBlue, AppTheme.syntaxPurple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.syntaxBlue.withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.code, color: Colors.white, size: 30),
              ).animate()
                .slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOutBack)
                .then()
                .shimmer(duration: 2.seconds, color: Colors.white54),
            ],
          ),
        ],
      ),
    );
  }
}
