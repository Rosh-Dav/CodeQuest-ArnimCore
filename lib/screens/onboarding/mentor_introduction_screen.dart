import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../utils/theme.dart';
import '../../widgets/background/code_background.dart';
import '../../widgets/onboarding/ai_mentor_widget.dart';
import '../login_screen.dart';

class MentorIntroductionScreen extends StatefulWidget {
  final String username;
  final String selectedLanguage;
  final String selectedStoryMode;

  const MentorIntroductionScreen({
    super.key,
    required this.username,
    required this.selectedLanguage,
    required this.selectedStoryMode,
  });

  @override
  State<MentorIntroductionScreen> createState() => _MentorIntroductionScreenState();
}

class _MentorIntroductionScreenState extends State<MentorIntroductionScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _initMentor();
  }

  Future<void> _initMentor() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Configure TTS for natural female voice
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setVoice({"name": "Google US English", "locale": "en-US"});
    
    if (widget.selectedStoryMode == 'Rune City Quest') {
      // Luna - Warm, friendly mentor
      await _flutterTts.setPitch(1.1); // Slightly higher for female voice
      await _flutterTts.setSpeechRate(0.48); // Slower, more natural
    } else {
      // Stella - Energetic, motivational coach
      await _flutterTts.setPitch(1.15); // Higher pitch for energetic feel
      await _flutterTts.setSpeechRate(0.52); // Slightly faster but still natural
    }

    // Speak greeting
    setState(() => _isSpeaking = true);
    await _speak(_getGreeting());
    
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _isSpeaking = false;
        _showButton = true;
      });
    }
  }

  String _getGreeting() {
    final mentorName = widget.selectedStoryMode == 'Rune City Quest'
        ? 'Luna'
        : 'Stella';
    
    return "Welcome ${widget.username}! I'm $mentorName, your coding mentor. "
        "You've chosen ${widget.selectedLanguage} and entered ${widget.selectedStoryMode}. "
        "I'll guide you through your coding journey. Let's begin!";
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  void _continue() {
    // TODO: Navigate to dashboard
    // For now, go back to login
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ideBackground,
      body: Stack(
        children: [
          // Animated Background
          const Positioned.fill(
            child: CodeBackground(),
          ),

          // Dimmed Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ).animate().fadeIn(duration: 600.ms),

          // Content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // AI Mentor
                  AIMentorWidget(
                    storyMode: widget.selectedStoryMode,
                    greeting: _getGreeting(),
                    showWaveform: _isSpeaking,
                  ),

                  const SizedBox(height: 60),

                  // Continue Button
                  if (_showButton)
                    ElevatedButton(
                      onPressed: _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.selectedStoryMode == 'Rune City Quest'
                            ? AppTheme.syntaxYellow
                            : AppTheme.syntaxBlue,
                        foregroundColor: AppTheme.ideBackground,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Begin Journey',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.arrow_forward, size: 24),
                        ],
                      ),
                    ).animate().fadeIn().scale(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
