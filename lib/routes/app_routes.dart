import 'package:go_router/go_router.dart';
import 'package:sovellukseni/screens/topic_screen.dart';
import 'package:sovellukseni/screens/quiz_screen.dart';
import 'package:sovellukseni/screens/statistics_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => TopicListScreen(),
    ),
   GoRoute(
      path: '/quiz/:topicId',
      builder: (context, state) {
        final topicId = int.parse(state.pathParameters['topicId']!);
        return QuizScreen(topicId: topicId);
      },
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => StatisticsScreen(),
    ),
  ],
  
);
