import 'package:flutter/material.dart';
import '../../../../shared/glass_container.dart';

class QuizWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final int correctIndex;
  final Function(bool) onAnswered;

  const QuizWidget({
    super.key,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.onAnswered,
  });

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int? _selectedIndex;
  bool _isAnswered = false;

  void _handleTap(int index) {
    if (_isAnswered) return;

    setState(() {
      _selectedIndex = index;
      _isAnswered = true;
    });

    widget.onAnswered(index == widget.correctIndex);
  }

  Color _getOptionColor(int index, ThemeData theme) {
    if (!_isAnswered) {
      return _selectedIndex == index ? theme.colorScheme.primary.withOpacity(0.1) : Colors.white;
    }

    if (index == widget.correctIndex) {
      return Colors.green.withOpacity(0.2); // Correct
    }

    if (index == _selectedIndex && index != widget.correctIndex) {
      return Colors.red.withOpacity(0.2); // Wrong
    }

    return Colors.white.withOpacity(0.5); // Disabled
  }

  Color _getBorderColor(int index, ThemeData theme) {
      if (!_isAnswered) return Colors.transparent;
      
      if (index == widget.correctIndex) return Colors.green;
      if (index == _selectedIndex) return Colors.red;
      
      return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Question
        GlassContainer(
          child: Text(
            widget.question,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),

        // Options
        ...List.generate(widget.options.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: () => _handleTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _getOptionColor(index, theme),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isAnswered ? _getBorderColor(index, theme) : Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    if (!_isAnswered)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.5),
                        ),
                        color: _isAnswered && index == widget.correctIndex ? theme.colorScheme.primary : Colors.transparent,
                      ),
                      child: _isAnswered && index == widget.correctIndex
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : Center(child: Text('${String.fromCharCode(65 + index)}', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.options[index],
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
