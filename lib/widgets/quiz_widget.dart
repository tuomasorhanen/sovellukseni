import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sovellukseni/services/quiz_service.dart';

class QuizWidget extends ConsumerStatefulWidget {
  final int topicId;

  QuizWidget({required this.topicId});

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends ConsumerState<QuizWidget> {
  bool? _isCorrect;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final questionFuture = ref.watch(questionFutureProvider(widget.topicId));

    return questionFuture.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error loading question')),
      data: (question) {
        return Column(
          children: [
            Text(question.question),
            for (var option in question.options)
              ElevatedButton(
                onPressed: () => _submitAnswer(question.answerPostPath, option),
                child: Text(option),
              ),
            if (_isCorrect != null)
              Text(
                _isCorrect! ? 'Correct!' : 'Incorrect, try again.',
                style: TextStyle(color: _isCorrect! ? Colors.green : Colors.red),
              ),
            if (_isCorrect == true)
              ElevatedButton(
                onPressed: () => setState(() {
                  _isCorrect = null;
                  ref.refresh(questionFutureProvider(widget.topicId));
                }),
                child: Text('Next Question'),
              ),
          ],
        );
      },
    );
  }

  Future<void> _submitAnswer(String answerPostPath, String answer) async {
    setState(() {
      _isLoading = true;
    });
    final correct = await ref.read(quizServiceProvider).postAnswer(answerPostPath, answer);
    setState(() {
      _isCorrect = correct;
      _isLoading = false;
    });
  }
}
