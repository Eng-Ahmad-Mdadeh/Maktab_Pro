part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitialState extends SplashState {}

class NavigationToIntroScreenState extends SplashState {}

class NavigationToHomeScreenState extends SplashState {}

class NavigationToEditProfileScreen extends SplashState {}

class ConnectionFailed extends SplashState {}
