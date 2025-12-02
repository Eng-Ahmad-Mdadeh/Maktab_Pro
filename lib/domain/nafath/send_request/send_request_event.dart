import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/nafath/send_request_model.dart';

class SendRequestEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetSendRequestEvent extends SendRequestEvent {
  final String nafath;

  GetSendRequestEvent(this.nafath);

  @override
  List<Object> get props => [nafath];
}
