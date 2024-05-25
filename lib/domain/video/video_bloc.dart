import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(const InitVideoState(isPlaying: false)) {
    on<InitVideoEvent>((event, emit) async {
      emit(state.copyWith(isPlaying: false));
    });
    on<PlayVideoEvent>((event, emit) async {
      emit(state.copyWith(isPlaying: true));
    });
    on<PauseVideoEvent>((event, emit) async {
      emit(state.copyWith(isPlaying: false));
    });
    on<EndVideoEvent>((event, emit) async {
      emit(state.copyWith(isPlaying: false));
    });
  }
}
