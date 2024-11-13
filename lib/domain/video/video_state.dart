
part of 'video_bloc.dart';

class VideoState extends Equatable {
  final bool? isPlaying;

  const VideoState({required this.isPlaying});

  @override
  List<Object?> get props => [isPlaying];
  VideoState copyWith({
    bool? isPlaying,
  }) {
    return VideoState(
      isPlaying: isPlaying,
    );
  }
}

final class InitVideoState extends VideoState {
  const InitVideoState({required super.isPlaying});
}
