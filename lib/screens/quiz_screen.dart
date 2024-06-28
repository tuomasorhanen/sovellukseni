import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sovellukseni/widgets/quiz_widget.dart';

class QuizScreen extends StatelessWidget {
  final int topicId;

  QuizScreen({required this.topicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        actions: [
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Topics'),
          ),
          TextButton(
        onPressed: () => context.go("/statistics"),
        child: const Text("Statistics"),
      ),
        ],
      ),
      body: QuizWidget(topicId: topicId),
    );
  }
}
