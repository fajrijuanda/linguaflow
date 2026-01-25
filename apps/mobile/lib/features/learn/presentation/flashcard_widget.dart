import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../shared/glass_container.dart';

class FlashcardWidget extends StatefulWidget {
  final String frontText;
  final String backText;
  final String? frontSub;
  final String? backSub;

  const FlashcardWidget({
    super.key,
    required this.frontText,
    required this.backText,
    this.frontSub,
    this.backSub,
  });

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: _animation.value < 0.5
                ? _buildSide(
                    theme,
                    widget.frontText,
                    widget.frontSub,
                    isFront: true,
                  )
                : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: _buildSide(
                      theme,
                      widget.backText,
                      widget.backSub,
                      isFront: false,
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSide(ThemeData theme, String text, String? sub, {required bool isFront}) {
    return GlassContainer(
      color: isFront ? Colors.white : theme.colorScheme.primaryContainer,
      opacity: isFront ? 0.7 : 0.9,
      child: SizedBox(
        width: 300,
        height: 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: theme.textTheme.displayMedium?.copyWith(
                  color: isFront ? theme.colorScheme.onSurface : theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (sub != null) ...[
                const SizedBox(height: 16),
                Text(
                  sub,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: isFront ? Colors.grey : theme.colorScheme.onPrimaryContainer.withOpacity(0.7),
                  ),
                ),
              ],
              const SizedBox(height: 48),
              Icon(
                Icons.touch_app,
                color: (isFront ? Colors.grey : theme.colorScheme.onPrimaryContainer).withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
