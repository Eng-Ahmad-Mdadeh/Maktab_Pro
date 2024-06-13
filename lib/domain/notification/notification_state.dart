part of 'notification_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();
}

final class NotificationsInitial extends NotificationsState {
  @override
  List<Object> get props => [];
}

final class NotificationsLoading extends NotificationsState {
  @override
  List<Object> get props => [];
}

final class NotificationsSuccess extends NotificationsState{
  final List<NotificationModel> notifications;
  const NotificationsSuccess(this.notifications);

  @override
  List<Object?> get props => notifications;
}

final class NotificationsFailure extends NotificationsState {
  final String message;

  const NotificationsFailure(this.message);

  @override
  List<Object> get props => [];
}
