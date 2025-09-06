import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../create_meet/presentation/pages/create_meet_page.dart';
import '../../../../core/di/locator.dart';
import '../../../meet/presentation/bloc/last_meets_bloc.dart';
import '../../../meet/presentation/bloc/last_meets_event.dart';
import '../../../meet/presentation/pages/last_meets_section.dart';
import '../../../../core/common/widgets/default_show_modal_bottom_sheet_widget.dart';
import '../../../auth/presentation/bloc/user_bloc.dart';
import '../../../auth/presentation/bloc/user_event.dart';
import '../../../auth/presentation/bloc/user_state.dart';
import 'edit_profile_page.dart';
import '../widgets/circle_user_avatar_widget.dart';

class ProfilePage extends StatelessWidget {
  static const String route = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<LastMeetsBloc>()..add(GetLastMeetsEvent(refresh: true)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return DefaultShowModalBottomSheetWidget(
                          elements: [
                            ListTile(
                              leading: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              title: Text('Edit profile'),
                              onTap: () {
                                context.pop();
                                context.push(EditProfilePage.route);
                              },
                            ),

                            ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              title: Text(
                                'Sign out',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              onTap: () {
                                context.read<UserBloc>().add(LogOutEvent());
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),

            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleUserAvatarWidget(
                          height: 100,
                          width: 100,
                          url: state.user?.avatar,
                        ),

                        SizedBox(width: 15),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${state.user?.name}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              '${state.user?.email}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: .8),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Text(
                      state.user?.bio ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: .8),
                      ),
                    ),

                    SizedBox(height: 20),

                    InkWell(
                      onTap: () => context.push(CreateMeetPage.route),
                      child: Text(
                        'Last meets',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),

                    SizedBox(height: 10),

                    LastMeetsSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
