part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ToggleMessageOptionsEvent extends AuthEvent {}
class CheckProfileEvent extends AuthEvent {}
class TimerBeginEvent extends AuthEvent {}
class TimerCompleted extends AuthEvent {
  final String phone;
  final String messageType;

  const TimerCompleted(this.phone, this.messageType);
}

class LoginEvent extends AuthEvent {
  final String phone;
  final String messageType;

  const LoginEvent(this.phone, this.messageType);
}

class CheckCodeEvent extends AuthEvent {
  final String phone;
  final String code;

  const CheckCodeEvent(this.code, this.phone);
}
