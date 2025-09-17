import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/create_meet/create_meet_event.dart';
import 'package:social_network_platform/features/create_meet/presentation/bloc/create_meet/create_meet_state.dart';
import 'package:social_network_platform/features/meet/domain/usecases/create_meet_usecase.dart';

class CreateMeetBloc extends Bloc<CreateMeetEvent, CreateMeetState> {
  final CreateMeetUsecase _createMeetUsecase;

  CreateMeetBloc({required CreateMeetUsecase createMeetUsecase})
    : _createMeetUsecase = createMeetUsecase,
      super(CreateMeetState.initial()) {
    on<CreateMeetEvent>(_onCreateMeetEvent);
  }

  Future<void> _onCreateMeetEvent(
    CreateMeetEvent event,
    Emitter<CreateMeetState> emit,
  ) async {
    emit(state.copyWith(status: CreateMeetStatus.loading));

    final result = await _createMeetUsecase(
      CreateMeetParams(
        title: event.title,
        description: event.description,
        time: event.time,
        location: event.location,
      ),
    );

    result.fold(
      (l) {
        emit(
          state.copyWith(
            status: CreateMeetStatus.error,
            errorMessage: l.message,
          ),
        );
      },
      (r) {
        emit(state.copyWith(status: CreateMeetStatus.error, createdMeet: r));
      },
    );
  }
}
