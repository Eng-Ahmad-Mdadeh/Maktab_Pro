part of 'home_bloc.dart';

enum HomeApiCallState { initial, loading, update, success, failure }

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class GetStatisticsEvent extends HomeEvent {}
