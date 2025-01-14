import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/statistics/statistics_model.dart';
import 'package:maktab_lessor/data/repositories/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;
  HomeBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const HomeState()) {
    on<GetStatisticsEvent>((event, emit) async {
      emit(state.copyWith(homeApiCallState: HomeApiCallState.loading));
      final result = await _userRepository.getStatistics();
      result.fold(
        (failure) =>
            emit(state.copyWith(homeApiCallState: HomeApiCallState.failure)),
        (statistics) => emit(state.copyWith(
            statistics: statistics,
            homeApiCallState: HomeApiCallState.success)),
      );
    });
  }
}
