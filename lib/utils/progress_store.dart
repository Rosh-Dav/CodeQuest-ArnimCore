import 'package:shared_preferences/shared_preferences.dart';

class ProgressStore {
  static const String _completedLevelsKey = 'rune_city_python_completed_levels';
  static const String _currentLevelKey = 'rune_city_python_current_level';

  Future<Set<String>> loadCompletedLevels() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_completedLevelsKey) ?? <String>[];
    return list.toSet();
  }

  Future<void> markCompleted(String levelId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_completedLevelsKey) ?? <String>[];
    if (!list.contains(levelId)) {
      list.add(levelId);
      await prefs.setStringList(_completedLevelsKey, list);
    }
  }

  Future<int> loadCurrentLevelIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_currentLevelKey) ?? 0;
  }

  Future<void> saveCurrentLevelIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentLevelKey, index);
  }
}
