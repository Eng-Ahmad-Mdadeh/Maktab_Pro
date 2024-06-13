part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class SetOfficeCalendarsEvent extends CalendarEvent{
  final int officeID;
  final int priceID;
  final List<Calendar> calendars;

  const SetOfficeCalendarsEvent(this.officeID, this.priceID, this.calendars);

  @override
  List<Object?> get props => [];
}

class DeleteOfficeCalendarsEvent extends CalendarEvent{
  final int officeID;
  final List<Calendar> calendars;

  const DeleteOfficeCalendarsEvent(this.officeID, this.calendars);

  @override
  List<Object?> get props => [];
}

class GetCalendars extends CalendarEvent{
  @override
  List<Object?> get props => [];
}