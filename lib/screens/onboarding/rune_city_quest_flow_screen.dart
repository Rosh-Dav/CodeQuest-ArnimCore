import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utils/progress_store.dart';
import '../../utils/theme.dart';
import '../../widgets/background/code_background.dart';

class RuneCityQuestFlowScreen extends StatefulWidget {
  final String username;
  final String selectedLanguage;
  final String selectedStoryMode;

  const RuneCityQuestFlowScreen({
    super.key,
    required this.username,
    required this.selectedLanguage,
    required this.selectedStoryMode,
  });

  @override
  State<RuneCityQuestFlowScreen> createState() => _RuneCityQuestFlowScreenState();
}

class _RuneCityQuestFlowScreenState extends State<RuneCityQuestFlowScreen> {
  final ProgressStore _progressStore = ProgressStore();
  late final List<_LevelData> _levels;
  int _currentLevelIndex = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _levels = _buildLevels();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final index = await _progressStore.loadCurrentLevelIndex();
    if (mounted) {
      setState(() {
        _currentLevelIndex = index.clamp(0, _levels.length - 1);
        _loading = false;
      });
    }
  }

  Future<void> _advanceLevel() async {
    final nextIndex = (_currentLevelIndex + 1).clamp(0, _levels.length - 1);
    await _progressStore.saveCurrentLevelIndex(nextIndex);
    if (mounted) {
      setState(() {
        _currentLevelIndex = nextIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final level = _levels[_currentLevelIndex];

    return Scaffold(
      backgroundColor: AppTheme.ideBackground,
      body: Stack(
        children: [
          const Positioned.fill(child: CodeBackground()),
          _LevelBackdrop(accent: level.accent),
          SafeArea(
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(color: level.accent),
                  )
                : LevelLessonScreen(
                    level: level,
                    username: widget.username,
                    onLevelCleared: _advanceLevel,
                  ),
          ),
        ],
      ),
    );
  }
}

class _LevelBackdrop extends StatelessWidget {
  final Color accent;

  const _LevelBackdrop({required this.accent});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.2, -0.6),
              radius: 1.2,
              colors: [
                accent.withValues(alpha: 0.22),
                AppTheme.ideBackground.withValues(alpha: 0.9),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LevelData {
  final String id;
  final String title;
  final String topic;
  final String storyTask;
  final String lesson;
  final List<String> concepts;
  final String outcome;
  final String mcqQuestion;
  final List<String> mcqOptions;
  final int mcqCorrectIndex;
  final String typedQuestion;
  final String typedAnswer;
  final Color accent;

  const _LevelData({
    required this.id,
    required this.title,
    required this.topic,
    required this.storyTask,
    required this.lesson,
    required this.concepts,
    required this.outcome,
    required this.mcqQuestion,
    required this.mcqOptions,
    required this.mcqCorrectIndex,
    required this.typedQuestion,
    required this.typedAnswer,
    required this.accent,
  });
}

List<_LevelData> _buildLevels() {
  return [
    _LevelData(
      id: 'rune_py_1',
      title: 'Level 1 — The First Rune',
      topic: '(Variables)',
      storyTask:
          'Create a rune to store citizen energy. Assign a value, update it, display it using print().',
      lesson:
          'Tutor: In Python, variables are like runes that store energy. You assign values with = and can update them anytime. '
          'Use input() to take user energy and print() to display it back.',
      concepts: [
        'Variables',
        'Assigning values',
        'Reassigning values',
        'input() to take user input',
        'print() to display values',
      ],
      outcome: 'City memory starts working.',
      mcqQuestion: 'Which line correctly assigns 10 to a variable named energy?',
      mcqOptions: const ['energy == 10', 'energy = 10', '10 = energy', 'energy := 10'],
      mcqCorrectIndex: 1,
      typedQuestion: 'Which function prints output to the screen?',
      typedAnswer: 'print',
      accent: AppTheme.syntaxBlue,
    ),
    _LevelData(
      id: 'rune_py_2',
      title: 'Level 2 — Endless Work',
      topic: '(Loops)',
      storyTask:
          'Automate city systems like street lamps, fountains, and alarms. Repeat tasks using loops.',
      lesson:
          'Tutor: Loops let the city repeat tasks automatically. Use for when you know how many times, '
          'and while when you loop until a condition changes.',
      concepts: [
        'for loops',
        'while loops',
        'Loop control using variables',
        'input() to decide number of repetitions',
        'print() inside loops for output',
      ],
      outcome: 'Automatic systems start working.',
      mcqQuestion: 'Which loop is best for repeating a task a fixed number of times?',
      mcqOptions: const ['for', 'while', 'if', 'def'],
      mcqCorrectIndex: 0,
      typedQuestion: 'What keyword stops a loop early?',
      typedAnswer: 'break',
      accent: AppTheme.syntaxYellow,
    ),
    _LevelData(
      id: 'rune_py_3',
      title: 'Level 3 — Decision Point',
      topic: '(Conditions)',
      storyTask:
          'City must react differently depending on situations: open gate, raise alert, stop system.',
      lesson:
          'Tutor: Conditions let the city decide. Use if for the first check, elif for another check, '
          'and else as the fallback.',
      concepts: [
        'if, elif, else statements',
        'Comparison operators (>, <, ==, !=)',
        'input() to take decisions from player',
        'print() for dynamic output',
      ],
      outcome: 'City systems respond correctly.',
      mcqQuestion: 'Which statement checks another condition after an if?',
      mcqOptions: const ['else', 'elif', 'for', 'while'],
      mcqCorrectIndex: 1,
      typedQuestion: 'What operator means "not equal" in Python?',
      typedAnswer: '!=',
      accent: AppTheme.syntaxPurple,
    ),
    _LevelData(
      id: 'rune_py_4',
      title: 'Level 4 — Helpful Runes',
      topic: '(Functions)',
      storyTask:
          'Repeated tasks like healing citizens or activating shields are converted into functions.',
      lesson:
          'Tutor: Functions package tasks into reusable spells. Define them with def and call them by name. '
          'Parameters let your spell adapt to the situation.',
      concepts: [
        'Function creation using def',
        'Function parameters',
        'Calling functions',
        'Using input() to control function behavior',
        'print() for output',
      ],
      outcome: 'City tasks become efficient and organized.',
      mcqQuestion: 'Which keyword defines a function in Python?',
      mcqOptions: const ['func', 'define', 'def', 'lambda'],
      mcqCorrectIndex: 2,
      typedQuestion: 'How do you call a function named heal?',
      typedAnswer: 'heal()',
      accent: AppTheme.syntaxGreen,
    ),
    _LevelData(
      id: 'rune_py_5',
      title: 'Level 5 — Many Runes',
      topic: '(Data Structures)',
      storyTask:
          'Handle multiple city readings like energy levels, magic, water. Store and display them.',
      lesson:
          'Tutor: Lists store many values in order. You can index them, update them, and append new values. '
          'Dictionaries store key-value pairs when you need names for each reading.',
      concepts: [
        'Lists: creation, indexing, updating',
        'Iteration over lists',
        'Appending values based on input()',
        'Optional dictionaries for key-value storage',
        'print() to display collections',
      ],
      outcome: 'City database restored and stable.',
      mcqQuestion: 'Which list method adds a new item to the end?',
      mcqOptions: const ['add()', 'append()', 'push()', 'insert()'],
      mcqCorrectIndex: 1,
      typedQuestion: 'What is the first index of a list in Python?',
      typedAnswer: '0',
      accent: AppTheme.syntaxBlue,
    ),
  ];
}

class LevelLessonScreen extends StatelessWidget {
  final _LevelData level;
  final String username;
  final VoidCallback onLevelCleared;

  const LevelLessonScreen({
    super.key,
    required this.level,
    required this.username,
    required this.onLevelCleared,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          level.title,
          style: AppTheme.headingStyle.copyWith(fontSize: 30),
        ).animate().fadeIn().slideY(begin: -0.1, end: 0),
        const SizedBox(height: 8),
        Text(
          level.topic,
          style: AppTheme.codeStyle.copyWith(
            color: level.accent,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Tutor Says',
          accent: level.accent,
          child: Text(
            level.lesson,
            style: AppTheme.bodyStyle.copyWith(fontSize: 15),
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Key Concepts',
          accent: level.accent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: level.concepts
                .map(
                  (concept) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '• $concept',
                      style: AppTheme.bodyStyle.copyWith(fontSize: 14),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Story / Task',
          accent: level.accent,
          child: Text(
            level.storyTask,
            style: AppTheme.bodyStyle.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Learning Outcome',
          accent: level.accent,
          child: Text(
            level.outcome,
            style: AppTheme.bodyStyle.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () async {
            final passed = await Navigator.of(context).push<bool>(
              MaterialPageRoute(
                builder: (_) => LevelQuizScreen(level: level),
              ),
            );
            if (passed == true && context.mounted) {
              onLevelCleared();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${level.title} cleared!'),
                  backgroundColor: level.accent,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: level.accent,
            foregroundColor: AppTheme.ideBackground,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Take Quiz',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Color accent;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.accent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.idePanel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.codeStyle.copyWith(
              color: AppTheme.syntaxComment,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class LevelQuizScreen extends StatefulWidget {
  final _LevelData level;

  const LevelQuizScreen({super.key, required this.level});

  @override
  State<LevelQuizScreen> createState() => _LevelQuizScreenState();
}

class _LevelQuizScreenState extends State<LevelQuizScreen> {
  int? _selectedIndex;
  final TextEditingController _typedController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _typedController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedIndex == null || _typedController.text.trim().isEmpty) {
      setState(() => _error = 'Answer both questions to continue.');
      return;
    }

    final mcqCorrect = _selectedIndex == widget.level.mcqCorrectIndex;
    final typedCorrect = _typedController.text.trim().toLowerCase() ==
        widget.level.typedAnswer.trim().toLowerCase();
    final passed = mcqCorrect && typedCorrect;

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.idePanel,
          title: Text(
            passed ? 'Level Cleared' : 'Try Again',
            style: AppTheme.headingStyle.copyWith(fontSize: 20),
          ),
          content: Text(
            passed
                ? 'Great job! Rune City upgrades are online.'
                : 'One or more answers were incorrect. Review the lesson and retry.',
            style: AppTheme.bodyStyle.copyWith(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (passed) {
                  Navigator.of(context).pop(true);
                }
              },
              child: Text(
                passed ? 'Continue' : 'Retry',
                style: AppTheme.codeStyle.copyWith(color: widget.level.accent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ideBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.ideBackground,
        foregroundColor: Colors.white,
        title: const Text('Level Quiz'),
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: CodeBackground()),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  widget.level.title,
                  style: AppTheme.headingStyle.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'Question 1 (MCQ)',
                  accent: widget.level.accent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.level.mcqQuestion,
                        style: AppTheme.bodyStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(
                        widget.level.mcqOptions.length,
                        (index) => RadioListTile<int>(
                          value: index,
                          groupValue: _selectedIndex,
                          activeColor: widget.level.accent,
                          onChanged: (value) => setState(() {
                            _selectedIndex = value;
                            _error = null;
                          }),
                          title: Text(
                            widget.level.mcqOptions[index],
                            style: AppTheme.bodyStyle.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'Question 2 (Typed)',
                  accent: widget.level.accent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.level.typedQuestion,
                        style: AppTheme.bodyStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _typedController,
                        style: AppTheme.bodyStyle.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Type your answer...',
                          filled: true,
                          fillColor: AppTheme.ideBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (_) => setState(() => _error = null),
                      ),
                    ],
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: AppTheme.bodyStyle.copyWith(
                      color: Colors.redAccent,
                      fontSize: 13,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.level.accent,
                    foregroundColor: AppTheme.ideBackground,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Answers',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
