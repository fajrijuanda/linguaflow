import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/login_screen.dart';

// Simple state provider for testing generic theming
final currentLangProvider = StateProvider<String>((ref) => 'EN');

void main() {
  runApp(const ProviderScope(child: LinguaFlowApp()));
}

class LinguaFlowApp extends ConsumerWidget {
  const LinguaFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langCode = ref.watch(currentLangProvider);

    return MaterialApp(
      title: 'LinguaFlow',
      theme: AppTheme.getTheme(langCode),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
