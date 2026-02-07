import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../services/story_state_service.dart';

class StoryTriggerManager {
  final LocalStorageService _storage = LocalStorageService();
  final StoryStateService _storyState = StoryStateService();

  /// Checks if the condition for Python ByteStar Arena Phase 1 is met
  /// 1. Language == Python
  /// 2. Story == ByteStar Arena
  /// 3. storyStarted == false
  Future<bool> shouldStartPhase1(String? language, String? storyMode) async {
    if (language == null || storyMode == null) {
      return false;
    }
    
    // Check persistance
    await _storyState.init();
    if (_storyState.storyStarted) {
      return false; // Already started, should depend on saved state where to go
    }

    return language == 'Python' && storyMode == 'Byte Star Arena';
  }

  /// Checks stored preferences and determines the next route
  /// Returns '/story/python/phase1/opening' if triggered, '/home' otherwise
  Future<String> checkAndTriggerStory() async {
    final language = await _storage.getSelectedLanguage();
    final storyMode = await _storage.getSelectedStoryMode();

    if (await shouldStartPhase1(language, storyMode)) {
      return '/story/python/phase1/opening';
    }
    
    // If story is already started, we might want to go to mission select or continue
    // For now, default to home or mission 1 if active
    if (await _storyState.storyStarted) {
       // Could route to mission 1 directly
       return '/story/python/mission';
    }

    return '/home';
  }
}
