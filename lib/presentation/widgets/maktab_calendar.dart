// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/calendar_cell.dart';
import 'package:table_calendar/table_calendar.dart';

class MaktabCalendar extends StatelessWidget {
  const MaktabCalendar({
    super.key,
    this.headerVisible = false,
    this.daysOfWeekVisible = false,
    this.availableGestures = AvailableGestures.none,
    required this.month,
    required this.year,
    this.focusedDay,
    this.rowHeight,
    required this.width,
    this.outsideDaysVisible = false,
    this.calendarFormat = CalendarFormat.month,
    this.titleTextStyle,
    required this.selectedDates,
    this.defaultBuilder,
    this.todayBuilder,
    this.selectedBuilder,
    this.onDayLongPressed,
  });

  final bool headerVisible;
  final bool daysOfWeekVisible;
  final AvailableGestures availableGestures;
  final int month;
  final int year;
  final DateTime? focusedDay;
  final double? rowHeight;
  final double width;
  final bool outsideDaysVisible;
  final TextStyle? titleTextStyle;
  final CalendarFormat calendarFormat;
  final List<DateTime> selectedDates;
  final Widget? Function(
      BuildContext context, DateTime day, DateTime focusedDay)? defaultBuilder;
  final Widget? Function(
      BuildContext context, DateTime day, DateTime focusedDay)? todayBuilder;
  final Widget? Function(
      BuildContext context, DateTime day, DateTime focusedDay)? selectedBuilder;
  final Function(DateTime day, DateTime focusedDay)? onDayLongPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TableCalendar(
        locale: 'ar',
        availableGestures: availableGestures,
        headerVisible: headerVisible,
        daysOfWeekVisible: daysOfWeekVisible,
        rowHeight: rowHeight ?? 50.v,
        calendarFormat: calendarFormat,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
          CalendarFormat.twoWeeks: '2 weeks',
          CalendarFormat.week: 'Week'
        },
        calendarStyle: CalendarStyle(
            outsideDaysVisible: outsideDaysVisible,
            outsideTextStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.softAsh)),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextFormatter: (date, locale) =>
              '${DateFormat.MMM(locale).format(date)} ${DateFormat.yM(locale).format(date)}',
          titleTextStyle: titleTextStyle ??
              Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
          leftChevronVisible: false,
          rightChevronVisible: false,
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: AppColors.black,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: AppColors.black,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Theme.of(context).textTheme.bodyLarge!,
            weekendStyle: Theme.of(context).textTheme.bodyLarge!),
        focusedDay: focusedDay ?? DateTime(year, month, 1),
        firstDay: DateTime(year - 5, month, 1),
        lastDay: DateTime(year + 10, month + 1, 0),
        selectedDayPredicate: (day) {
          for (var date in selectedDates) {
            if (isSameDay(date, day)) {
              return true;
            }
          }
          return false;
        },
        rangeSelectionMode: RangeSelectionMode.toggledOn,
        onRangeSelected: (start, end, focusedDay) {},
        calendarBuilders: CalendarBuilders(
          defaultBuilder: defaultBuilder ??
              (context, day, focusedDay) {
                return CalendarCell(date: day);
              },
          todayBuilder: todayBuilder ??
              (context, day, focusedDay) {
                return CalendarCell(date: day);
              },
          selectedBuilder: selectedBuilder ??
              (context, day, focusedDay) {
                return CalendarCell(date: day);
              },
        ),
        onDayLongPressed: onDayLongPressed,
      ),
    );
  }
}
