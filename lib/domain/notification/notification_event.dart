part of 'notification_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}


final class GetNotificationsEvent extends NotificationsEvent{
  @override
  List<Object?> get props => [];
}

final class DeleteNotificationEvent extends NotificationsEvent{
  final int id;

  const DeleteNotificationEvent(this.id);

  @override
  List<Object?> get props => [];
}

final class SetSeenNotificationEvent extends NotificationsEvent{
  final int id;

  const SetSeenNotificationEvent(this.id);

  @override
  List<Object?> get props => [];
}