import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_platform/features/meet/domain/usecases/get_meet_usecase.dart';
import 'package:social_network_platform/features/meet/presentation/bloc/meet_event.dart';
import 'package:social_network_platform/features/meet/presentation/bloc/meet_states.dart';

class MeetBloc extends Bloc<GetMeetEvent, MeetStates> {
  final GetMeetUsecase _getMeetUsecase;

  MeetBloc({required GetMeetUsecase getMeetUsecase})
    : _getMeetUsecase = getMeetUsecase,
      super(MeetStates.initail()) {
    on<GetMeetEvent>(_onGetMeetEvent);
  }

  Future<void> _onGetMeetEvent(
    GetMeetEvent event,
    Emitter<MeetStates> emit,
  ) async {
    emit(state.copyWith(status: MeetStatus.loading));

    final result = await _getMeetUsecase(GetMeetParams(meetId: event.meetId));

    result.fold(
      (l) => emit(
        state.copyWith(status: MeetStatus.error, errorMessage: l.message),
      ),
      (r) => emit(state.copyWith(status: MeetStatus.success, meet: r)),
    );
  }
}
