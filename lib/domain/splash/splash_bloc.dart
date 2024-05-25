import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/repositories/auth_repository.dart';
import 'package:maktab/data/repositories/profile_repository.dart';
import 'package:maktab/domain/profile/profile_bloc.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository;

  SplashBloc(
      {required AuthRepository authRepository,
      required ProfileRepository profileRepository})
      : _authRepository = authRepository,
        super(SplashInitialState()) {
    on<CheckAuthenticationEvent>((event, emit) async {
      await _navigateTo(emit, event);
    });
  }

  Future<void> _navigateTo(Emitter<SplashState> emit, SplashEvent event) async {
    log("here");
    bool authState = await _authRepository.checkAuthentication();

    if (authState) {
      ProfileBloc profileBloc=locator<ProfileBloc>();
      profileBloc.add(GetProfileEvent());
      await profileBloc.stream.firstWhere(
        (state) {
          return state.profileState != ProfileStates.loading;
        },
      );
      if (profileBloc.state.profileState == ProfileStates.failure) {
        emit(ConnectionFailed());
        return;
      }
      if (profileBloc
              .checkIfProfileCompleted(locator<ProfileBloc>().state.user!) ==
          true) {
        emit(NavigationToHomeScreenState());
      } else {
        profileBloc.add(GetUserTypes());
        emit(NavigationToEditProfileScreen());
      }
    } else {
      emit(NavigationToIntroScreenState());
    }
  }
}
