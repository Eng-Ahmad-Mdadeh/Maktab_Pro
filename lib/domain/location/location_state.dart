
part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitialState extends LocationState {}

final class LocationLoadingState extends LocationState {}

final class LocationSuccessState extends LocationState {
  Position position;

  LocationSuccessState(this.position);
}

final class LocationFailureState extends LocationState {}
