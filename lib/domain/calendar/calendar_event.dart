part of 'calendar_bloc.dart';

enum CalendarFormatOptions { hour, day }

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

final class SelectCalendarFormatOptionEvent extends CalendarEvent {
  final CalendarFormatOptions option;

  const SelectCalendarFormatOptionEvent(this.option);
}

final class AddSelectedDayEvent extends CalendarEvent {
  final DateTime day;

  const AddSelectedDayEvent(this.day);
}

final class AddSelectedHourEvent extends CalendarEvent {
  final DateTime hour;

  const AddSelectedHourEvent(this.hour);
}

final class SelectDayEvent extends CalendarEvent {
  final DateTime day;

  const SelectDayEvent(this.day);
}

final class SelectRangeDayEvent extends CalendarEvent {
  final DateTime day;

  const SelectRangeDayEvent(this.day);
}

final class SelectRangeHourEvent extends CalendarEvent {
  final DateTime hour;

  const SelectRangeHourEvent(this.hour);
}
