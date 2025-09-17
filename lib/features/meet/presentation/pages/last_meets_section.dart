import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_platform/features/meet/presentation/widgets/last_meets_widget.dart';
import '../bloc/last_meets_bloc.dart';
import '../bloc/last_meets_state.dart';

class LastMeetsSection extends StatelessWidget {
  const LastMeetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastMeetsBloc, LastMeetsState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.lastMeets?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return LastMeetsWidget(meet: state.lastMeets![index]);
          },
        );
      },
    );
  }
}
