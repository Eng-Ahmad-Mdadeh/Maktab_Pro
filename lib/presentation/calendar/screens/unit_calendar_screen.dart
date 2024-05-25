// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/calendar/calendar_bloc.dart';
import 'package:maktab/presentation/calendar/widgets/calendar_header.dart';
import 'package:maktab/presentation/calendar/widgets/daily_calendar_section.dart';
import 'package:maktab/presentation/calendar/widgets/hourly_calendar_section.dart';
import 'package:maktab/presentation/calendar/widgets/range_calendar_section.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';

class UnitCalendarScreen extends StatefulWidget {
  const UnitCalendarScreen({super.key, required this.unit});

  final Office unit;

  @override
  State<UnitCalendarScreen> createState() => _UnitCalendarScreenState();
}

class _UnitCalendarScreenState extends State<UnitCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MaktabAppBar(title: widget.unit.title),
      body: SafeArea(
        child: SizedBox(
          width: SizeHelper.width,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.v, horizontal: 20.h),
                  child: Column(
                    children: [
                      CalendarHeader(unit: widget.unit),
                      DailyCalendarSection(unit: widget.unit),
                      BlocBuilder<CalendarBloc, CalendarState>(
                        builder: (context, state) {
                          return state.format == CalendarFormatOptions.hour
                              ? HourlyCalendarSection(unit: widget.unit)
                              : const SizedBox.shrink();
                        },
                      ),
                      const RangeCalendarSection(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.h),
                  child: Row(
                    children: [
                      Flexible(
                        child: MaktabButton(
                          text: 'اشغال',
                          backgroundColor: AppColors.lightCyan,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 15.h),
                      Flexible(
                        child: MaktabButton(
                          text: 'اتاحة',
                          backgroundColor: AppColors.slateGray,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
