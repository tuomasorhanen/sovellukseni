import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question {
  final int id;
  final String question;
  final List<String> options;
  final String answerPostPath;

  Question({required this.id, required this.question, required this.options, required this.answerPostPath});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answerPostPath: json['answer_post_path'],
    );
  }
}

class QuizService {
  final String _endpoint = 'https://dad-quiz-api.deno.dev';

 Future<Question> fetchQuestion(int topicId) async {
    final response = await http.get(Uri.parse('$_endpoint/topics/$topicId/questions'));
    final data = jsonDecode(response.body);
    return Question.fromJson(data);
  }

  Future<bool> postAnswer(String answerPostPath, String answer) async {
    final response = await http.post(
      Uri.parse('$_endpoint$answerPostPath'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'answer': answer}),
    );
    final data = jsonDecode(response.body);

    final prefs = await SharedPreferences.getInstance();
    if (data['correct']) {
      int correctAnswers = prefs.getInt('correct_answers') ?? 0;
      prefs.setInt('correct_answers', correctAnswers + 1);
    }

    return data['correct'];
  }
}

final quizServiceProvider = Provider<QuizService>((ref) => QuizService());

final questionFutureProvider = FutureProvider.family<Question, int>((ref, topicId) async {
  return await ref.watch(quizServiceProvider).fetchQuestion(topicId);
});