part of 'auth_bloc.dart';

enum MessageOptionStetes { show, hide }

enum LoginStates { initial, loading, success, failure,reLoading,reSuccess,reFailed }

enum CodeStates { initial, loading, success, failure }
enum TimerStates { initial,begin,running, completed }
enum ProfileCompleteness { initial,unknown,complete,unComplete }
class AuthState extends Equatable {
  const AuthState({
    required this.option,
    required this.loginState,
    required this.codeState,
    required this.phone,
    required this.message,
    required this.messageType,
    required this.duration,
    required this.timerState,
    required this.profileCompleteness,
  });

  final MessageOptionStetes option;
  final LoginStates loginState;
  final TimerStates timerState;
  final CodeStates codeState;
  final String phone;
  final String message;
  final String messageType;
  final int duration;
  final ProfileCompleteness profileCompleteness;

  @override
  List<Object> get props =>
      [option, loginState, codeState, phone, message, duration, timerState,messageType,profileCompleteness];

  AuthState copyWith({
    MessageOptionStetes? option,
    LoginStates? loginState,
    CodeStates? codeState,
    String? phone,
    String? message,
    String? messageType,
    int? duration,
    TimerStates? timerState,
    final ProfileCompleteness? profileCompleteness
  }) {
    return AuthState(
        option: option ?? this.option,
        loginState: loginState ?? this.loginState,
        codeState: codeState ?? this.codeState,
        phone: phone ?? this.phone,
        message: message ?? this.message,
        duration: duration ?? this.duration,
        timerState: timerState ?? this.timerState,
        messageType: messageType??this.messageType,
        profileCompleteness: profileCompleteness??this.profileCompleteness
    );
  }
}
