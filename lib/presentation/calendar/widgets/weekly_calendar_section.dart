// import 'package:flutter/material.dart';
// import 'package:maktab/core/helpers/size_helper.dart';
// import 'package:maktab/presentation/calendar/widgets/unit_calendar.dart';
// import 'package:table_calendar/table_calendar.dart';

// class WeeklyCalendarSection extends StatelessWidget {
//   const WeeklyCalendarSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
//       children: [
//         UnitCalendar(
//           month: DateTime.now().month,
//           availableGestures: AvailableGestures.horizontalSwipe,
//           calendarFormat: CalendarFormat.week,
//           ranges: [
//             {
//               'start': DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month,
//                 2,
//               ),
//               'end': DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month,
//                 7,
//               ),
//             },
//             {
//               'start': DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month,
//                 DateTime.now().day + 2,
//               ),
//               'end': DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month,
//                 DateTime.now().day + 2,
//               ),
//             },
//           ],
//         ),
//         UnitCalendar(
//           month: DateTime.now().month + 1,
//           calendarFormat: CalendarFormat.week,
//           ranges: [
//             {
//               'start': DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month + 1,
//                 DateTime.now().day + 2,
//               ),
//               'end': DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month + 1,
//                 DateTime.now().day + 10,
//               ),
//             },
//           ],
//         ),
//         UnitCalendar(
//           month: DateTime.now().month + 2,
//           calendarFormat: CalendarFormat.week,
//           ranges: [
//             {
//               'start': DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month + 2,
//                 DateTime.now().day + 2,
//               ),
//               'end': DateTime(
//                 DateTime.now().year,
//                 DateTime.now().month + 2,
//                 DateTime.now().day + 12,
//               ),
//             },
//           ],
//         ),
//       ],
//     );
//   }
// }
