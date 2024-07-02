// // ignore_for_file: depend_on_referenced_packages
//
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maktab_lessor/domain/calendar/calendar_bloc.dart';
// import 'package:maktab_lessor/presentation/resources/app_colors.dart';
// import 'package:maktab_lessor/presentation/widgets/calendar_cell.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class HourlyCalendarCell extends StatelessWidget {
//   const HourlyCalendarCell({super.key, required this.date});
//
//   final DateTime date;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarBloc, CalendarState>(
//       builder: (context, state) {
//         return CalendarCell(
//           date: date,
//           isHour: true,
//           isCircle: false,
//           textColor: state.selectedHours.contains(date)
//               ? AppColors.slateGray
//               : state.unSelectedHours.contains(date)
//                   ? AppColors.slateGray
//                   : AppColors.black,
//           backgroundColor: state.selectedHours.contains(date)
//               ? AppColors.smokeGray
//               : state.unSelectedHours.contains(date)
//                   ? AppColors.palePlatinum
//                   : AppColors.white,
//           lineThrough: state.unSelectedHours.contains(date),
//           onLongPress: () {
//             context
//                 .read<CalendarBloc>()
//                 .add(AddSelectedHourEvent(date.toLocal()));
//           },
//           onDoubleTap: () {
//             context.read<CalendarBloc>().add(SelectRangeHourEvent(date));
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
