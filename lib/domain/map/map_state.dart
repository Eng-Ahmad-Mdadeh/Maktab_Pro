// ignore_for_file: must_be_immutable

part of 'map_cubit.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitialState extends MapState {}
