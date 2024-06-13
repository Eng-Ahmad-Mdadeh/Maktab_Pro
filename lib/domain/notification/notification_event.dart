part of 'notification_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}


final class GetNotificationsEvent extends NotificationsEvent{
  @override
  List<Object?> get props => [];
}