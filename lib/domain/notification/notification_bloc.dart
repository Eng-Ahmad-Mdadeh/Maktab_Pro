import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/notification/notification_model.dart';
import '../../data/repositories/notification_repository.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository _repository;

  NotificationsBloc(this._repository) : super(NotificationsInitial()) {
    on<GetNotificationsEvent>((event, emit) async {
      emit(NotificationsLoading());
      try {
        final result = await _repository.getNotifications();
        result.fold(
          (l) => emit(NotificationsFailure(l.message)),
          (r) => emit(NotificationsSuccess(r)),
        );
      } catch (e) {
        emit(NotificationsFailure(e.toString()));
      }
    });
  }
}
