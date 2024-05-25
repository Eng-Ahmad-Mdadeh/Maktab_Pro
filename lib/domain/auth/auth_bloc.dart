// ignore_for_file: invalid_use_of_visible_for_testing_member, depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/repositories/auth_repository.dart';
import 'package:maktab/domain/profile/profile_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  Timer? timer;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState(
            option: MessageOptionStetes.hide,
            loginState: LoginStates.initial,
            codeState: CodeStates.initial,
            phone: '',
            message: '',
            timerState: TimerStates.initial,
            duration: 120,
            messageType: '',
            profileCompleteness: ProfileCompleteness.initial)) {
    on<ToggleMessageOptionsEvent>((event, emit) {
      _toggleMessageOptions(emit, event);
    });
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(
          loginState: LoginStates.loading,
          codeState: CodeStates.initial,
          profileCompleteness: ProfileCompleteness.initial));
      try {
        var result = await _authRepository.login(
            phone: event.phone, messageType: event.messageType);
        await Future.delayed(const Duration(seconds: 4));
        result.fold(
          (failure) => emit(state.copyWith(
            loginState: LoginStates.failure,
            phone: event.phone,
            message: failure.message,
          )),
          (message) => emit(state.copyWith(
              loginState: LoginStates.success,
              phone: event.phone,
              message: message,
              messageType: event.messageType)),
        );
      } catch (e) {
        emit(state.copyWith(
          loginState: LoginStates.failure,
          phone: event.phone,
          message: e.toString(),
        ));
      }
    });
    on<CheckCodeEvent>((event, emit) async {
      emit(state.copyWith(
          loginState: LoginStates.initial, codeState: CodeStates.loading));
      try {
        var result = await _authRepository.checkCode(
            phone: event.phone, code: event.code);

        result.fold(
          (failure) => emit(state.copyWith(
            codeState: CodeStates.failure,
            phone: event.phone,
            message: failure.message,
          )),
          (message) {
            timer?.cancel();
            emit(state.copyWith(
              codeState: CodeStates.success,
              timerState: TimerStates.completed,
              phone: event.phone,
              message: message,
            ));
          },
        );
      } catch (e) {
        emit(state.copyWith(
          codeState: CodeStates.failure,
          phone: event.phone,
          message: e.toString(),
        ));
      }
    });

    on<TimerCompleted>((event, emit) async {
      emit(state.copyWith(
          loginState: LoginStates.reLoading,
          duration: 120,
          timerState: TimerStates.initial,
          codeState: CodeStates.initial));
      try {
        var result = await _authRepository.login(
            phone: event.phone, messageType: event.messageType);
        await Future.delayed(const Duration(seconds: 4));
        result.fold(
          (failure) => emit(state.copyWith(
            loginState: LoginStates.reFailed,
            phone: event.phone,
            message: failure.message,
          )),
          (message) {
            emit(state.copyWith(
              loginState: LoginStates.reSuccess,
              duration: 120,
              timerState: TimerStates.begin,
              phone: event.phone,
              message: message,
            ));
            emit(state.copyWith(
              loginState: LoginStates.initial
            ));
            startTimer();
          },
        );
      } catch (e) {
        emit(state.copyWith(
          loginState: LoginStates.reFailed,
          phone: event.phone,
          message: e.toString(),
        ));
      }
    });
    on<CheckProfileEvent>((event, emit) async {
      bool? isComplete = await _checkProfileCompleteness();
      if (isComplete == null) {
        emit(state.copyWith(
            profileCompleteness: ProfileCompleteness.unknown,
            codeState: CodeStates.initial));
      } else if (isComplete == true) {
        emit(state.copyWith(
            profileCompleteness: ProfileCompleteness.complete,
            codeState: CodeStates.initial));
      } else {
        emit(state.copyWith(
            profileCompleteness: ProfileCompleteness.unComplete,
            codeState: CodeStates.initial));
      }
    });
  }

  Future<bool?> _checkProfileCompleteness() async {
    locator<ProfileBloc>().add(GetProfileEvent());
    await locator<ProfileBloc>().stream.firstWhere(
          (state) => state.profileState != ProfileStates.loading,
        );
    if (locator<ProfileBloc>().state.profileState == ProfileStates.failure) {
      return null;
    }
    if (locator<ProfileBloc>()
            .checkIfProfileCompleted(locator<ProfileBloc>().state.user!) ==
        true) {
      return true;
    } else {
      return false;
    }
  }

  void _toggleMessageOptions(Emitter<AuthState> emit, AuthEvent event) {
    state.option == MessageOptionStetes.show
        ? emit(state.copyWith(
            option: MessageOptionStetes.hide,
            loginState: LoginStates.initial,
          ))
        : emit(state.copyWith(
            option: MessageOptionStetes.show,
            loginState: LoginStates.initial,
          ));
  }

  cancelTimer() {
    timer?.cancel();
    emit(state.copyWith(
        loginState: LoginStates.initial,
        duration: 120,
        timerState: TimerStates.initial,
        codeState: CodeStates.initial));
  }

  startTimer() {
    if (timer?.isActive == true) {
      cancelTimer();
    }
    state.copyWith(duration: 120);

    const duration = Duration(seconds: 1);
    int remainingSeconds = 120;

    timer = Timer.periodic(duration, (time) {
      if (remainingSeconds == 0) {
        timer?.cancel();

        add(TimerCompleted(state.phone, state.messageType));

        return;
      } else {
        emit(state.copyWith(
            duration: remainingSeconds,
            loginState: LoginStates.initial,
            timerState: TimerStates.running,
            codeState: CodeStates.initial));
      }

      remainingSeconds--;
    });
  }
}
