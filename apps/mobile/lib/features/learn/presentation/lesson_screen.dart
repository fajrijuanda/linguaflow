import 'package:flutter/material.dart';
import '../../../shared/glass_container.dart';
import 'dart:math'; // For random if needed
import 'flashcard_widget.dart';
import 'quiz_widget.dart';

class LessonScreen extends StatefulWidget {
  final String courseId;
  const LessonScreen({super.key, required this.courseId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentStep = 0;
  final int _totalSteps = 10;
  int _lives = 5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Mock data for now
    final isFlashcard = _currentStep % 2 == 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / _totalSteps,
            minHeight: 12,
            backgroundColor: Colors.grey.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: Colors.red, size: 20),
                const SizedBox(width: 4),
                Text(
                  '$_lives',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                child: Center(
                  child: isFlashcard 
                    ? const FlashcardWidget(
                        frontText: '안녕하세요',
                        backText: 'Hello',
                        frontSub: 'annyeonghaseyo',
                        backSub: 'Common Greeting',
                      )
                    : QuizWidget(
                        question: 'How do you say "Thank You"?',
                        options: const ['감사합니다', '안녕하세요', '죄송합니다', '사랑해요'],
                        correctIndex: 0,
                        onAnswered: (isCorrect) {
                           // Handle logic
                           print('Answer: $isCorrect');
                        },
                      ),
                ),
                ),
              ),
            ),
            const Spacer(),
            // Bottom Action Area
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_currentStep < _totalSteps - 1) {
                              _currentStep++;
                            } else {
                              // Unit Complete
                              Navigator.of(context).pop(); 
                            }
                          });
                        },
                        child: Text(_currentStep < _totalSteps - 1 ? 'CHECK' : 'FINISH'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
