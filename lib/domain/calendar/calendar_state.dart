part of 'calendar_bloc.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();
}

final class CalendarInitial extends CalendarState {
  @override
  List<Object> get props => [];
}

final class CalendarLoading extends CalendarState {
  @override
  List<Object> get props => [];
}

final class CalendarSuccess extends CalendarState {
  final Office unit;
  const CalendarSuccess(this.unit);

  @override
  List<Object> get props => [];
}

final class CalendarFailure extends CalendarState {
  final String message;

  const CalendarFailure(this.message);

  @override
  List<Object> get props => [];
}
