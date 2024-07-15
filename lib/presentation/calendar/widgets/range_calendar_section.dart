// // ignore_for_file: depend_on_referenced_packages
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maktab_lessor/core/extension/date_time_extension.dart';
// import 'package:maktab_lessor/core/helpers/size_helper.dart';
// import 'package:maktab_lessor/domain/calendar/calendar_bloc.dart';
// import 'package:maktab_lessor/presentation/widgets/section_title.dart';
//
// class RangeCalendarSection extends StatelessWidget {
//   const RangeCalendarSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CalendarBloc, CalendarState>(
//       builder: (context, state) {
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: 20.v),
//           child: Column(
//             children: [
//               state.selectedDays.contains(state.startRangeDate) ||
//                       state.selectedHours.contains(state.startRangeDate)
//                   ? const SectionTitle(title: 'تم تحديد:')
//                   : state.unSelectedDays.contains(state.startRangeDate) ||
//                           state.unSelectedHours.contains(state.startRangeDate)
//                       ? const SectionTitle(title: 'تم الغاء تحديد:')
//                       : const SizedBox.shrink(),
//               SizedBox(height: 20.v),
//               state.format == CalendarFormatOptions.day
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         state.selectedDays.contains(state.startRangeDate) ||
//                                 state.unSelectedDays
//                                     .contains(state.startRangeDate)
//                             ? SectionTitle(
//                                 title:
//                                     'من اليوم: ${state.startRangeDate.dayFormatWithLocale('ar')}',
//                               )
//                             : const SizedBox.shrink(),
//                         SizedBox(height: 10.v),
//                         state.selectedDays.contains(state.endRangeDate) ||
//                                 state.unSelectedDays
//                                     .contains(state.endRangeDate)
//                             ? SectionTitle(
//                                 title:
//                                     'الى اليوم: ${state.endRangeDate.dayFormatWithLocale('ar')}',
//                               )
//                             : const SizedBox.shrink(),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         state.selectedHours.contains(state.startRangeDate) ||
//                                 state.unSelectedHours
//                                     .contains(state.startRangeDate)
//                             ? SectionTitle(
//                                 title:
//                                     'من الساعة: ${state.startRangeDate.hourFormatWithLocale('ar')}',
//                               )
//                             : const SizedBox.shrink(),
//                         SizedBox(height: 10.v),
//                         state.selectedHours.contains(state.endRangeDate) ||
//                                 state.unSelectedHours
//                                     .contains(state.endRangeDate)
//                             ? SectionTitle(
//                                 title:
//                                     'الى الساعة: ${state.endRangeDate.hourFormatWithLocale('ar')}',
//                               )
//                             : const SizedBox.shrink(),
//                       ],
//                     ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
