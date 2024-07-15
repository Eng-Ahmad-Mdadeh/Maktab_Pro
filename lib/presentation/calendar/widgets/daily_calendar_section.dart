// // ignore_for_file: depend_on_referenced_packages
//
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maktab_lessor/core/extension/date_time_extension.dart';
// import 'package:maktab_lessor/core/helpers/size_helper.dart';
// import 'package:maktab_lessor/data/models/office/office_model.dart';
// import 'package:maktab_lessor/domain/calendar/calendar_bloc.dart';
// import 'package:maktab_lessor/presentation/calendar/widgets/daily_calendar_cell.dart';
// import 'package:maktab_lessor/presentation/calendar/widgets/select_date_widget.dart';
// import 'package:maktab_lessor/presentation/widgets/calendar_range_cell.dart';
// import 'package:maktab_lessor/presentation/widgets/maktab_calendar.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class DailyCalendarSection extends StatelessWidget {
//   const DailyCalendarSection(this._controller, {super.key, required this.unit});
//
//   final DateRangePickerController _controller;
//   final Office unit;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//
//         SelectDateWidget(
//           _controller,
//           selectableDayPredicate: selectableDayPredicate,
//           offer: unit.offer,
//           calendars: unit.calendars,
//         ).animate().slideX(),
//         // MaktabCalendar(
//         //   width: SizeHelper.width,
//         //   headerVisible: true,
//         //   availableGestures: AvailableGestures.all,
//         //   month: context.read<CalendarBloc>().state.selectedDate.month,
//         //   year: context.read<CalendarBloc>().state.selectedDate.year,
//         //   daysOfWeekVisible: true,
//         //   calendarFormat: CalendarFormat.month,
//         //   outsideDaysVisible: true,
//         //   selectedDates: const [],
//         //   focusedDay: context.read<CalendarBloc>().state.focusedDate,
//         //   defaultBuilder: (context, date, focusedDay) {
//         //     for (var calendar in unit.calendars) {
//         //       if (date.isInRangeWithSameDay(calendar.startDate, calendar.endDate)) {
//         //         return CalendarRangeCell(
//         //           date: date,
//         //           isBeforeDate: calendar.startDate.isBefore(DateTime.now()),
//         //           isRangeStart: isSameDay(date, calendar.startDate),
//         //           isRangeEnd: isSameDay(date, calendar.endDate),
//         //           onTap: () {
//         //             context.read<CalendarBloc>().add(SelectDayEvent(DateTime(date.year, date.month, date.day)));
//         //           },
//         //         );
//         //       }
//         //     }
//         //     return DailyCalendarCell(day: DateTime(date.year, date.month, date.day));
//         //   },
//         //   todayBuilder: (context, date, focusedDay) {
//         //     return DailyCalendarCell(day: DateTime(date.year, date.month, date.day));
//         //   },
//         // ).animate().slideX(),
//       ],
//     );
//   }
//
//   bool selectableDayPredicate(DateTime date) {
//     return unit.calendars.every((calendar) {
//       return date.isBefore(calendar.startDate) || date.isAfter(calendar.endDate);
//     });
//   }
// }
