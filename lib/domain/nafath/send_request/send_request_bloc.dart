import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/data/repositories/nafath_repository.dart';
import 'package:maktab_lessor/domain/nafath/send_request/send_request_event.dart';
import 'package:maktab_lessor/domain/nafath/send_request/send_request_state.dart';


class SendRequestBloc extends Bloc<SendRequestEvent, SendRequestState> {
  final NafathRepository _repository;

  SendRequestBloc(this._repository) : super(InitialSendRequestState()) {
    on<GetSendRequestEvent>((event, emit) async {
      emit(LoadingSendRequestState());
      try {
        final result = await _repository.sendRequest(event.nafath);
        result.fold(
          (l) => emit(FailureSendRequestState(l.message)),
          (r) => emit(SuccessSendRequestState(r)),
        );
      } catch (e) {
        emit(FailureSendRequestState(e.toString()));
      }
    });
  }
}
