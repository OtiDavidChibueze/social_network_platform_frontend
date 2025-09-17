import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_image_urls.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../../../main/presentation/pages/main_page.dart';

class AuthPage extends StatelessWidget {
  static const String route = '/auth';
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.success) {
            context.go(MainPage.route);
          }

          if (state.status == UserStatus.error) {
            debugPrint(state.errorMessage);

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meet Up',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        'By DhavyeScript Solutions',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),

                      SizedBox(height: 20),

                      Expanded(
                        child: Center(child: Image.asset(AppImageUrls.group)),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Find events. Meet people, Stay connected',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 5),

                      Text(
                        'Discover exciting event, nearby, connect with new people, and create your own meetups!',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      Spacer(),

                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surface,

                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<UserBloc>().add(
                              SignInWithGoogleEvent(),
                            );
                          },
                          label: Text('Sign in with google'),
                          icon: Image.asset(AppImageUrls.google, width: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
