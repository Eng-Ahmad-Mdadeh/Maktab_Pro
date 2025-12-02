import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/nafath/send_request_model.dart';

class SendRequestState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialSendRequestState extends SendRequestState {}

final class LoadingSendRequestState extends SendRequestState {}

final class SuccessSendRequestState extends SendRequestState {
  final SendRequestModel? nafathModel;

  SuccessSendRequestState(this.nafathModel);

  @override
  List<Object?> get props => [nafathModel];
}

final class FailureSendRequestState extends SendRequestState {
  final String message;

  FailureSendRequestState(this.message);
}
