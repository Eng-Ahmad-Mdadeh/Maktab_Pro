import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/nafath/request_status_model.dart';
import 'package:maktab_lessor/data/models/nafath/send_request_model.dart';

class RequestStatusState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialRequestStatusState extends RequestStatusState {}

final class LoadingRequestStatusState extends RequestStatusState {}

final class SuccessRequestStatusState extends RequestStatusState {
  final RequestStatusModel? nafathModel;

  SuccessRequestStatusState(this.nafathModel);

  @override
  List<Object?> get props => [nafathModel];
}

final class FailureRequestStatusState extends RequestStatusState {
  final String message;

  FailureRequestStatusState(this.message);
}
