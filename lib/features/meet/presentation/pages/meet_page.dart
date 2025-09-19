import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_platform/core/di/locator.dart';
import 'package:social_network_platform/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:social_network_platform/features/meet/presentation/bloc/meet_event.dart';
import 'package:social_network_platform/features/meet/presentation/bloc/meet_states.dart';

class MeetPage extends StatelessWidget {
  final String meetId;

  const MeetPage({super.key, required this.meetId});

  static String route(String meetId) => 'meet/$meetId';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          getIt<MeetBloc>()..add(GetMeetEvent(meetId: meetId)),
      child: Scaffold(),
    );
  }
}
