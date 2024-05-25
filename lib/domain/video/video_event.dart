part of 'video_bloc.dart';

sealed class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

final class InitVideoEvent extends VideoEvent {}

final class PlayVideoEvent extends VideoEvent {}

final class PauseVideoEvent extends VideoEvent {}

final class EndVideoEvent extends VideoEvent {}
