import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/calendar/calender_model.dart';
import '../../data/models/office/office_model.dart';
import '../../data/repositories/calendar_repository.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository _repository;

  CalendarBloc(this._repository) : super(CalendarInitial()) {
    on<SetOfficeCalendarsEvent>((event, emit) async {
      emit(CalendarLoading());
      try{
        print("event.calendars.first.startDate: ${event.calendars.first.startDate}");
        print("event.calendars.first.endDate: ${event.calendars.first.endDate}");
        final result = await _repository.setOfficeCalendars(
          officeId: event.officeID,
          priceId: event.priceID,
          calendars: event.calendars,
        );

        print(result);

        result.fold(
              (l) {
                throw(l);
                // emit(CalendarFailure(l.message));
              },
              (r) {
                emit(CalendarSuccess(r));

              },
        );
      }catch(e){
        rethrow;
        // emit(CalendarFailure(e.toString()));
      }
    });

    on<DeleteOfficeCalendarsEvent>((event, emit) async {
      emit(CalendarLoading());
      try{
        print("event.officeID delete: ${event.officeID}");
        print("event.calendars.first.id delete: ${event.calendars.first.id}");
        print("event.calendars.first.startDate delete: ${event.calendars.first.startDate}");
        print("event.calendars.first.endDate delete: ${event.calendars.first.endDate}");
        final result = await _repository.deleteCalendarFromOffice(
          officeId: event.officeID,
          calendars: event.calendars,
        );

        print(result);

        result.fold(
              (l) {
            // throw(l);
            emit(CalendarFailure(l.message));
          },
              (r) {
            emit(CalendarSuccess(r));

          },
        );
      }catch(e){
        // rethrow;
        emit(CalendarFailure(e.toString()));
      }
    });
  }
}
