import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
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
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(NotificationsFailure(e.toString()));
      }
    });

    on<DeleteNotificationEvent>((event, emit) async {
      emit(NotificationsLoading());
      try {
        final result = await _repository.deleteNotification(event.id);
        result.fold(
              (l) => emit(NotificationsFailure(l.message)),
              (r) => add(GetNotificationsEvent()),
        );
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(NotificationsFailure(e.toString()));
      }
    });

    on<SetSeenNotificationEvent>((event, emit) async {
      emit(NotificationsLoading());
      try {
        final result = await _repository.setNotificationSeen(event.id);
        result.fold(
              (l) => emit(NotificationsFailure(l.message)),
              (r) => add(GetNotificationsEvent()),
        );
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(NotificationsFailure(e.toString()));
      }
    });
  }
}
