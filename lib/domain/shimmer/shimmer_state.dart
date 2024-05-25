part of 'shimmer_bloc.dart';

sealed class ShimmerState extends Equatable {
  const ShimmerState();

  @override
  List<Object> get props => [];
}

final class ShimmerInitialState extends ShimmerState {}

final class ShowShimmerEffectState extends ShimmerState {}

final class HideShimmerEffectState extends ShimmerState {}
