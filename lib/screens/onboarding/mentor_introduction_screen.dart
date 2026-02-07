import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/theme.dart';
import '../../widgets/background/code_background.dart';
import '../../widgets/onboarding/ai_mentor_widget.dart';
import '../../services/local_storage_service.dart';
import '../../core/story_trigger_manager.dart';
import '../phase1/system_awakening_screen.dart';
import '../phase1/mission1_screen.dart';
import '../home_screen.dart';

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
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    // Simulate some initialization or animation delay if needed
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _showButton = true);
      }
    });
  }

  Future<void> _continue() async {
    // Save user preferences to local storage
    final storage = LocalStorageService();
    await storage.init();
    
    await storage.saveUsername(widget.username);
    await storage.saveSelectedLanguage(widget.selectedLanguage);
    await storage.saveSelectedStoryMode(widget.selectedStoryMode);
    await storage.saveOnboardingCompleted(true);

    // Check which story should be triggered
    final triggerManager = StoryTriggerManager();
    final route = await triggerManager.checkAndTriggerStory();

    if (!mounted) return;

    // Navigate to the appropriate screen
    if (route != '/home') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) {
           if (route == '/story/python/phase1/opening') {
             return const SystemAwakeningScreen();
           } else if (route == '/story/python/mission') {
             return const Mission1Screen();
           }
           return const HomeScreen();
        }),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    }
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
                    greeting: "Welcome ${widget.username}! You've chosen ${widget.selectedLanguage}. Let's begin!",
                    showWaveform: false,
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
