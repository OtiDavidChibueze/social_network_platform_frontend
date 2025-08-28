import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/user_bloc.dart';
import 'features/auth/presentation/bloc/user_state.dart';
import 'features/auth/presentation/pages/auth_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      builder: (context, child) {
        return BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.status == UserStatus.error ||
                state.status == UserStatus.logout) {
              AppRouter.router.go(AuthPage.route);
            }
          },
          child: child,
        );
      },
      routerConfig: AppRouter.router,
    );
  }
}
