import 'package:go_router/go_router.dart';
import 'package:social_network_platform/features/auth/presentation/pages/auth_page.dart';
import 'package:social_network_platform/main/presentation/pages/main_page.dart';

class AppRouter {
  static var router = GoRouter(
    initialLocation: AuthPage.route,
    routes: [
      GoRoute(
        path: AuthPage.route,
        builder: (context, state) {
          return AuthPage();
        },
      ),

      GoRoute(
        path: MainPage.route,
        builder: (context, state) {
          return MainPage();
        },
      ),
    ],
  );
}
