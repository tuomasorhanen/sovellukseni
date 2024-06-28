import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sovellukseni/services/topic_service.dart';

class TopicListWidget extends StatelessWidget {
  final List<Topic> topics;

  TopicListWidget({required this.topics});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: topics.map((topic) {
          return Column(
            children: [
              TextButton(
                onPressed: () => context.go('/quiz/${topic.id}'),
                child: Text(topic.name),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
