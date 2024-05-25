import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'shimmer_event.dart';
part 'shimmer_state.dart';

class ShimmerBloc extends Bloc<ShimmerEvent, ShimmerState> {
  ShimmerBloc() : super(ShimmerInitialState()) {
    on<BeginShimmerEffectEvent>((event, emit) async {
      emit(ShowShimmerEffectState());
      await Future.delayed(const Duration(seconds: 3), () {
        emit(HideShimmerEffectState());
      });
    });
  }
}
