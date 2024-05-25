// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/extension/date_time_extension.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/calendar/calendar_bloc.dart';
import 'package:maktab/presentation/calendar/widgets/hourly_calendar_cell.dart';
import 'package:maktab/presentation/widgets/calendar_range_cell.dart';
import 'package:maktab/presentation/widgets/section_title.dart';
import 'package:table_calendar/table_calendar.dart';

class HourlyCalendarSection extends StatelessWidget {
  const HourlyCalendarSection({super.key, required this.unit});

  final Office unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: SectionTitle(
              title: context
                  .read<CalendarBloc>()
                  .state
                  .selectedDate
                  .dayFormatWithLocale('ar'),
            ),
          ),
          SizedBox(height: 20.v),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: context
                .read<CalendarBloc>()
                .state
                .selectedDate
                .remainingHours
                .length,
            itemBuilder: (context, index) {
              DateTime selectedDate = context
                  .read<CalendarBloc>()
                  .state
                  .selectedDate
                  .copyWith(
                      hour: context
                          .read<CalendarBloc>()
                          .state
                          .selectedDate
                          .remainingHours[index]);
              for (var calendar in unit.calendars) {
                if (selectedDate.isInRangeWithSameMoment(
                    calendar.startDate, calendar.endDate)) {
                  return CalendarRangeCell(
                      date: selectedDate,
                      hourMode: true,
                      isBeforeDate: calendar.startDate.isBefore(DateTime.now()),
                      isRangeStart:
                          selectedDate.isAtSameMomentAs(calendar.startDate) ||
                              !isSameDay(selectedDate, calendar.startDate) &&
                                  selectedDate.remainingHours[index] == 0,
                      isRangeEnd: selectedDate
                              .isAtSameMomentAs(calendar.endDate) ||
                          !isSameDay(selectedDate, calendar.endDate) &&
                              selectedDate.remainingHours[index] == 23);
                }
              }
              return HourlyCalendarCell(
                  date: context
                      .read<CalendarBloc>()
                      .state
                      .selectedDate
                      .copyWith(hour: selectedDate.remainingHours[index]));
            },
          ),
        ],
      ),
    ).animate().fade();
  }
}
