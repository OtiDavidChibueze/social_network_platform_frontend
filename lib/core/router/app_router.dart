import 'package:go_router/go_router.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static var router = GoRouter(
    initialLocation: SplashPage.route,
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

      GoRoute(
        path: SplashPage.route,
        builder: (context, state) {
          return SplashPage();
        },
      ),

      GoRoute(
        path: ProfilePage.route,
        builder: (context, state) {
          return ProfilePage();
        },
      ),

      GoRoute(
        path: EditProfilePage.route,
        builder: (context, state) {
          return EditProfilePage();
        },
      ),
    ],
  );
}
