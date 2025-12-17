import 'package:go_router/go_router.dart';
import 'package:template_flutter/features/example_feature/presentation/pages/example_page.dart';
import 'package:template_flutter/features/home/presentation/pages/home_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/example',
        name: 'example',
        builder: (context, state) => const ExamplePage(),
      ),
    ],
  );
}
