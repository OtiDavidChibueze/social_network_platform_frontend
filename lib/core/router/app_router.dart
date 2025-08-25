import 'package:go_router/go_router.dart';
import 'package:social_network_platform/features/auth/presentation/pages/auth_page.dart';

class AppRouter {
  static var router = GoRouter(
    initialLocation: AuthPage.routeName,
    routes: [
      GoRoute(
        path: AuthPage.routeName,
        builder: (context, state) {
          return AuthPage();
        },
      ),
    ],
  );
}
