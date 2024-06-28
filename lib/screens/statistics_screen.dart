import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sovellukseni/services/topic_service.dart';

class StatisticsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPreferencesProvider);

    int correctAnswers = prefs.getInt('correct_answers') ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
         actions: [
         TextButton(
        onPressed: () => context.go("/statistics"),
        child: const Text("Statistics"),
      ),
        ],
      ),
      body: Center(
        child: Text('Correctly Answered Questions: $correctAnswers'),
      ),
    );
  }
}
