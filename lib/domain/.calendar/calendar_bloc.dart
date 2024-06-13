// // ignore_for_file: depend_on_referenced_packages, prefer_const_literals_to_create_immutables
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:maktab/data/models/calendar/calender_model.dart';
// part 'calendar_event.dart';
// part 'calendar_state.dart';
//
// class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
//   CalendarBloc()
//       : super(CalendarState(
//           format: CalendarFormatOptions.day,
//           focusedDate: DateTime.now(),
//           selectedDate: DateTime.now(),
//           firstSelectedDate: DateTime.now(),
//           secondSelectedDate: DateTime.now(),
//           startRangeDate: DateTime.now(),
//           endRangeDate: DateTime.now(),
//           selectedDays: [],
//           unSelectedDays: [],
//           selectedHours: [],
//           unSelectedHours: [],
//         )) {
//     on<SelectCalendarFormatOptionEvent>((event, emit) {
//       print("SelectCalendarFormatOptionEvent added");
//       emit(state.copyWith(
//         format: event.option,
//         startRangeDate: DateTime.now(),
//         endRangeDate: DateTime.now(),
//       ));
//     });
//     on<SelectDayEvent>((event, emit) {
//       print("SelectDayEvent added");
//       emit(state.copyWith(selectedDate: event.day));
//     });
//     on<AddSelectedDayEvent>((event, emit) {
//       print("AddSelectedDayEvent added");
//       List<DateTime> selectedDays = List.from(state.selectedDays);
//       List<DateTime> unSelectedDays = List.from(state.unSelectedDays);
//       if (event.day.isAfter(DateTime.now()) &&
//           state.format == CalendarFormatOptions.day) {
//         if (!selectedDays.contains(event.day)) {
//           selectedDays.add(event.day);
//           if (unSelectedDays.contains(event.day)) {
//             unSelectedDays.remove(event.day);
//           }
//         } else {
//           selectedDays.remove(event.day);
//           unSelectedDays.add(event.day);
//         }
//       }
//       emit(state.copyWith(
//         focusedDate: event.day,
//         selectedDate: event.day,
//         selectedDays: selectedDays,
//         unSelectedDays: unSelectedDays,
//       ));
//     });
//     on<AddSelectedHourEvent>((event, emit) {
//       print("AddSelectedHourEvent added");
//       List<DateTime> selectedHours = List.from(state.selectedHours);
//       List<DateTime> unSelectedHours = List.from(state.unSelectedHours);
//       if (event.hour.isAfter(DateTime.now())) {
//         if (!selectedHours.contains(event.hour)) {
//           selectedHours.add(event.hour);
//           if (unSelectedHours.contains(event.hour)) {
//             unSelectedHours.remove(event.hour);
//           }
//         } else {
//           selectedHours.remove(event.hour);
//           unSelectedHours.add(event.hour);
//         }
//       }
//       emit(state.copyWith(
//         format: state.format,
//         focusedDate: event.hour,
//         selectedDate: event.hour,
//         selectedHours: selectedHours,
//         unSelectedHours: unSelectedHours,
//       ));
//     });
//     on<SelectRangeDayEvent>((event, emit) {
//       print("SelectRangeDayEvent added");
//       List<DateTime> selectedDays = List.from(state.selectedDays);
//       List<DateTime> unSelectedDays = List.from(state.unSelectedDays);
//       if (state.isFirstRangeDateSelected && !state.isSecondRangeDateSelected) {
//         List<DateTime> dateRange =
//             Calendar.getDaysInBetween(state.firstSelectedDate, event.day);
//         for (DateTime day in dateRange) {
//           if (day.isAfter(DateTime.now()) &&
//               state.format == CalendarFormatOptions.day) {
//             if (!selectedDays.contains(day)) {
//               selectedDays.add(day);
//               if (unSelectedDays.contains(day)) {
//                 unSelectedDays.remove(day);
//               }
//             } else {
//               selectedDays.remove(day);
//               unSelectedDays.add(day);
//             }
//           }
//         }
//         emit(state.copyWith(
//           focusedDate: event.day,
//           selectedDate: event.day,
//           firstSelectedDate: DateTime.now(),
//           secondSelectedDate: DateTime.now(),
//           endRangeDate: event.day,
//           selectedDays: selectedDays,
//           unSelectedDays: unSelectedDays,
//         ));
//       } else {
//         if (event.day.isAfter(DateTime.now()) &&
//             state.format == CalendarFormatOptions.day) {
//           if (!selectedDays.contains(event.day)) {
//             selectedDays.add(event.day);
//             if (unSelectedDays.contains(event.day)) {
//               unSelectedDays.remove(event.day);
//             }
//           } else {
//             selectedDays.remove(event.day);
//             unSelectedDays.add(event.day);
//           }
//         }
//         emit(state.copyWith(
//           focusedDate: event.day,
//           selectedDate: event.day,
//           firstSelectedDate: event.day,
//           startRangeDate: event.day,
//           endRangeDate: DateTime.now(),
//           selectedDays: selectedDays,
//           unSelectedDays: unSelectedDays,
//         ));
//       }
//     });
//     on<SelectRangeHourEvent>((event, emit) {
//       print("SelectRangeHourEvent added");
//       List<DateTime> selectedHours = List.from(state.selectedHours);
//       List<DateTime> unSelectedHours = List.from(state.unSelectedHours);
//       if (state.isFirstRangeDateSelected && !state.isSecondRangeDateSelected) {
//         List<DateTime> dateRange =
//             getHoursInBetween(state.firstSelectedDate, event.hour);
//         for (DateTime hour in dateRange) {
//           if (hour.isAfter(DateTime.now())) {
//             if (!selectedHours.contains(hour)) {
//               selectedHours.add(hour);
//               if (unSelectedHours.contains(hour)) {
//                 unSelectedHours.remove(hour);
//               }
//             } else {
//               selectedHours.remove(hour);
//               unSelectedHours.add(hour);
//             }
//           }
//         }
//         emit(state.copyWith(
//           focusedDate: event.hour,
//           selectedDate: event.hour,
//           firstSelectedDate: DateTime.now(),
//           secondSelectedDate: DateTime.now(),
//           endRangeDate: event.hour,
//           selectedHours: selectedHours,
//           unSelectedHours: unSelectedHours,
//         ));
//       } else {
//         if (event.hour.isAfter(DateTime.now())) {
//           if (!selectedHours.contains(event.hour)) {
//             selectedHours.add(event.hour);
//             if (unSelectedHours.contains(event.hour)) {
//               unSelectedHours.remove(event.hour);
//             }
//           } else {
//             selectedHours.remove(event.hour);
//             unSelectedHours.add(event.hour);
//           }
//         }
//         emit(state.copyWith(
//           focusedDate: event.hour,
//           selectedDate: event.hour,
//           firstSelectedDate: event.hour,
//           startRangeDate: event.hour,
//           endRangeDate: DateTime.now(),
//           selectedHours: selectedHours,
//           unSelectedHours: unSelectedHours,
//         ));
//       }
//     });
//   }
//
//   bool isInDaysArray(List<DateTime> selelctedDates, DateTime date) {
//     for (var selectedDate in selelctedDates) {
//       if (isSameDay(selectedDate, date)) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   List<DateTime> getHoursInBetween(DateTime startDate, DateTime endDate) {
//     List<DateTime> hours = [];
//     for (int i = 1; i <= endDate.difference(startDate).inHours; i++) {
//       hours.add(startDate.add(Duration(hours: i)));
//     }
//     return hours;
//   }
// }
