import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/data/repositories/nafath_repository.dart';
import 'package:maktab_lessor/domain/nafath/request_status/request_status_event.dart';
import 'package:maktab_lessor/domain/nafath/request_status/request_status_state.dart';


class RequestStatusBloc extends Bloc<RequestStatusEvent, RequestStatusState> {
  final NafathRepository _repository;

  RequestStatusBloc(this._repository) : super(InitialRequestStatusState()) {
    on<GetRequestStatusEvent>((event, emit) async {
      emit(LoadingRequestStatusState());
      try {
        final result = await _repository.requestStatus();
        result.fold(
          (l) => emit(FailureRequestStatusState(l.message)),
          (r) => emit(SuccessRequestStatusState(r)),
        );
      } catch (e) {
        emit(FailureRequestStatusState(e.toString()));
      }
    });
  }
}
