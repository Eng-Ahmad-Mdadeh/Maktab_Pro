// // ignore_for_file: must_be_immutable
//
// part of 'calendar_bloc.dart';
//
// class CalendarState extends Equatable {
//   CalendarFormatOptions format;
//   DateTime focusedDate;
//   DateTime selectedDate;
//   DateTime firstSelectedDate;
//   DateTime secondSelectedDate;
//   DateTime startRangeDate;
//   DateTime endRangeDate;
//   List<DateTime> selectedDays;
//   List<DateTime> unSelectedDays;
//   List<DateTime> selectedHours;
//   List<DateTime> unSelectedHours;
//
//   CalendarState({
//     required this.format,
//     required this.selectedDate,
//     required this.focusedDate,
//     required this.selectedDays,
//     required this.firstSelectedDate,
//     required this.secondSelectedDate,
//     required this.startRangeDate,
//     required this.endRangeDate,
//     required this.unSelectedDays,
//     required this.selectedHours,
//     required this.unSelectedHours,
//   });
//
//   @override
//   List<Object> get props => [
//         format,
//         selectedDate,
//         focusedDate,
//         firstSelectedDate,
//         secondSelectedDate,
//         startRangeDate,
//         endRangeDate,
//         selectedDays,
//         unSelectedDays,
//         selectedHours,
//         unSelectedHours
//       ];
//
//   bool get isFirstRangeDateSelected =>
//       !isSameDay(firstSelectedDate, DateTime.now());
//
//   bool get isSecondRangeDateSelected =>
//       !isSameDay(secondSelectedDate, DateTime.now());
//
//   CalendarState copyWith({
//     CalendarFormatOptions? format,
//     DateTime? focusedDate,
//     DateTime? selectedDate,
//     DateTime? firstSelectedDate,
//     DateTime? secondSelectedDate,
//     DateTime? startRangeDate,
//     DateTime? endRangeDate,
//     List<DateTime>? selectedDays,
//     List<DateTime>? unSelectedDays,
//     List<DateTime>? selectedHours,
//     List<DateTime>? unSelectedHours,
//   }) {
//     return CalendarState(
//       format: format ?? this.format,
//       focusedDate: focusedDate ?? this.focusedDate,
//       selectedDate: selectedDate ?? this.selectedDate,
//       firstSelectedDate: firstSelectedDate ?? this.firstSelectedDate,
//       secondSelectedDate: secondSelectedDate ?? this.secondSelectedDate,
//       startRangeDate: startRangeDate ?? this.startRangeDate,
//       endRangeDate: endRangeDate ?? this.endRangeDate,
//       selectedDays: selectedDays ?? this.selectedDays,
//       unSelectedDays: unSelectedDays ?? this.unSelectedDays,
//       selectedHours: selectedHours ?? this.selectedHours,
//       unSelectedHours: unSelectedHours ?? this.unSelectedHours,
//     );
//   }
// }
