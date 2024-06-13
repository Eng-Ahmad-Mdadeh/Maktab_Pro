// // ignore_for_file: depend_on_referenced_packages
//
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maktab/domain/calendar/calendar_bloc.dart';
// import 'package:maktab/presentation/resources/app_colors.dart';
// import 'package:maktab/presentation/widgets/calendar_cell.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class DailyCalendarCell extends StatelessWidget {
//   const DailyCalendarCell({super.key, required this.day});
//
//   final DateTime day;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarBloc, CalendarState>(
//       builder: (context, state) {
//         return CalendarCell(
//           date: day,
//           textColor: state.selectedDays.contains(day) ||
//                   isInDaysArray(state.selectedHours, day)
//               ? AppColors.slateGray
//               : state.unSelectedDays.contains(day) ||
//                       isInDaysArray(state.unSelectedHours, day)
//                   ? AppColors.slateGray
//                   : AppColors.black,
//           backgroundColor: state.selectedDays.contains(day) ||
//                   isInDaysArray(state.selectedHours, day)
//               ? AppColors.smokeGray
//               : state.unSelectedDays.contains(day) ||
//                       isInDaysArray(state.unSelectedHours, day)
//                   ? AppColors.palePlatinum
//                   : AppColors.white,
//           borderColor: isSameDay(day, DateTime.now())
//               ? AppColors.royalPurple
//               : AppColors.white,
//           isAvailableDay: day.isAfter(DateTime.now()),
//           lineThrough: state.unSelectedDays.contains(day),
//           onTap: () {
//             context.read<CalendarBloc>().add(SelectDayEvent(day));
//           },
//           onLongPress: () {
//             context.read<CalendarBloc>().add(AddSelectedDayEvent(day));
//           },
//           onDoubleTap: () {
//             context.read<CalendarBloc>().add(SelectRangeDayEvent(day));
//           },
//         ).animate().fadeIn();
//       },
//     );
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
// }
