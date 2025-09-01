import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_last_meet_usecase.dart';
import 'last_meets_event.dart';
import 'last_meets_state.dart';

class LastMeetsBloc extends Bloc<LastMeetsEvent, LastMeetsState> {
  final GetLastMeetsUsecase _getLastMeetsUsecase;

  LastMeetsBloc({required GetLastMeetsUsecase getLastMeetsUsecase})
    : _getLastMeetsUsecase = getLastMeetsUsecase,
      super(LastMeetsState.initial()) {
    on<GetLastMeetsEvent>(_getLastMeets);
  }

  Future<void> _getLastMeets(
    GetLastMeetsEvent event,
    Emitter<LastMeetsState> emit,
  ) async {
    if (state.status == LastMeetsStatus.loading || state.isLastPage) {
      return;
    }

    if (event.refresh) {
      emit(state.copyWith(currentPage: 1, isLastPage: false, lastMeets: []));
    }

    emit(state.copyWith(status: LastMeetsStatus.loading));

    final result = await _getLastMeetsUsecase(
      GetLastMeetParams(page: state.currentPage, limit: 10),
    );

    result.fold(
      (l) {
        emit(
          state.copyWith(
            status: LastMeetsStatus.error,
            errorMessage: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            status: LastMeetsStatus.success,
            lastMeets: [...(state.lastMeets ?? []), ...r],
            currentPage: state.currentPage,
            isLastPage: r.length < 10,
          ),
        );
      },
    );
  }
}
