part of 'home_bloc.dart';

class HomeState extends Equatable {
  final Statistics? statistics;
  final HomeApiCallState homeApiCallState;

  const HomeState({
    this.statistics,
    this.homeApiCallState = HomeApiCallState.initial,
  });

  @override
  List<Object?> get props => [statistics, homeApiCallState];

  HomeState copyWith({
    Statistics? statistics,
    HomeApiCallState? homeApiCallState,
  }) {
    return HomeState(
      statistics: statistics ?? this.statistics,
      homeApiCallState: homeApiCallState ?? this.homeApiCallState,
    );
  }
}
