import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sovellukseni/services/topic_service.dart';
import 'package:sovellukseni/widgets/topic_widget.dart';

class TopicListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicFuture = ref.watch(topicFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz application'),
        actions: [
          TextButton(
            onPressed: () => context.go("/statistics"),
            child: const Text("Statistics"),
          ),
        ],
      ),
      body: topicFuture.when(
        loading: () => const Text("Loading..."),
        error: (err, stack) => const Text("No topics available"),
        data: (topics) {
          return TopicListWidget(topics: topics);
        },
      ),
    );
  }
}
