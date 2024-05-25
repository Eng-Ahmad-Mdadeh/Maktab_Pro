part of 'shimmer_bloc.dart';

sealed class ShimmerEvent extends Equatable {
  const ShimmerEvent();

  @override
  List<Object> get props => [];
}

class BeginShimmerEffectEvent extends ShimmerEvent {}
