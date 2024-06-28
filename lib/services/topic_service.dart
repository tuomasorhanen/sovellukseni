import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Topic {
  final int id;
  final String name;
  final String questionPath;

  Topic({required this.id, required this.name, required this.questionPath});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      name: json['name'],
      questionPath: json['question_path'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'question_path': questionPath,
      };
}

class TopicService {
  final _endpoint = 'https://dad-quiz-api.deno.dev';
  final SharedPreferences prefs;

  TopicService(this.prefs);

  Future<List<Topic>> getTopics() async {
    final response = await http.get(Uri.parse('$_endpoint/topics'));
    final data = jsonDecode(response.body) as List;
    final topics = data.map((json) => Topic.fromJson(json)).toList();
    await _saveTopicsToPrefs(topics);
    return topics;
  }

  Future<void> _saveTopicsToPrefs(List<Topic> topics) async {
    final String topicsJson = jsonEncode(topics.map((t) => t.toJson()).toList());
    await prefs.setString('topics', topicsJson);
  }

  Future<List<Topic>> loadTopicsFromPrefs() async {
    if (!prefs.containsKey('topics')) {
      return [];
    }
    final String? topicsJson = prefs.getString('topics');
    final List<dynamic> jsonData = jsonDecode(topicsJson!);
    return jsonData.map((json) => Topic.fromJson(json)).toList();
  }
}

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final topicServiceProvider = Provider<TopicService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TopicService(prefs);
});

final topicFutureProvider = FutureProvider<List<Topic>>((ref) async {
  return await ref.watch(topicServiceProvider).getTopics();
});
