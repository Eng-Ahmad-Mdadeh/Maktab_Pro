// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/extension/date_time_extension.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/presentation/calendar/widgets/calendar_header.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/services/service_locator.dart';
import '../../../data/models/aqar_filter/type_res.dart';
import '../../../data/models/calendar/calender_model.dart';
import '../../../domain/calendar/calendar_bloc.dart';
import '../../../domain/calendar/calendar_select_cubit.dart';
import '../../../domain/calendar/dates_select_cubit.dart';
import '../../../domain/entity/dates_selection_entity.dart';
import '../../../domain/offices/offices_cubit.dart';
import '../../widgets/order_status.dart';
import '../widgets/hour_range_picker_widget.dart';
import '../widgets/select_date_widget.dart';

class UnitCalendarScreen extends StatefulWidget {
  const UnitCalendarScreen({super.key, required this.unitId, required this.officeId});

  final int unitId;
  final int officeId;

  @override
  State<UnitCalendarScreen> createState() => _UnitCalendarScreenState();
}

class _UnitCalendarScreenState extends State<UnitCalendarScreen> {
  late Office unit;
  final DateRangePickerController _datePickerController = DateRangePickerController();
  late CalendarSelectCubit _calendarSelectCubit;
  late DatesSelectCubit _hourSelectCubit;

  @override
  void initState() {
    unit = context
        .read<OfficesCubit>()
        .state
        .calendars
        .where((e) => e.id == widget.officeId)
        .first
        .units
        .where((e) => e.id == widget.unitId)
        .first;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _calendarSelectCubit =
        CalendarSelectCubit(TypeRes.getCalenderFormat(unit.prices.first.typeRes?.arName ?? ''));
    _hourSelectCubit = DatesSelectCubit();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _calendarSelectCubit),
        BlocProvider(create: (_) => _hourSelectCubit),
        BlocProvider(create: (context) => locator<CalendarBloc>()),
      ],
      child: Scaffold(
        appBar: MaktabAppBar(title: unit.title ?? ''),
        body: SafeArea(
          child: SizedBox(
            width: SizeHelper.width,
            child: BlocConsumer<CalendarBloc, CalendarState>(
              listener: (context, state) {
                if (state is CalendarLoading) {
                  LoadingDialog.show(context);
                }
                if (state is CalendarFailure) {
                  LoadingDialog.hide(context);
                  log("CalendarFailure error: ${state.message}");
                }
                if (state is CalendarSuccess) {
                  LoadingDialog.hide(context);
                  _datePickerController.selectedRange = null;
                  _datePickerController.selectedDate = null;
                  context.read<DatesSelectCubit>().setTime(null, null);
                  context.read<OfficesCubit>().getCalendars();
                }
              },
              builder: (context, calenderState) {
                return BlocBuilder<CalendarSelectCubit, CalendarFormatOptions?>(
                  builder: (context, optionState) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 20.h),
                            child: Column(
                              children: [
                                CalendarHeader(unit: unit),
                                SelectDateWidget(
                                  _datePickerController,
                                  isSingle: optionState == CalendarFormatOptions.hour,
                                  offer: ((calenderState is CalendarSuccess) ? calenderState.unit : unit)
                                      .offers
                                      .where((e) => e.status)
                                      .firstOrNull,
                                  calendars: ((calenderState is CalendarSuccess) ? calenderState.unit : unit)
                                      .calendars,
                                  selectableDayPredicate: (date) =>
                                      ((calenderState is CalendarSuccess) ? calenderState.unit : unit)
                                          .calendars.every((calendar) {
                                        return date.isBefore(calendar.startDate) ||
                                            date.isAfter(calendar.endDate);
                                      }),
                                  onSelectionChanged: (args) {
                                    if (args.value is PickerDateRange) {
                                      final dates = args.value as PickerDateRange;
                                      context.read<DatesSelectCubit>().setDates(
                                          dates.startDate, dates.endDate);
                                    }
                                    if (args.value is DateTime) {
                                      final date = args.value as DateTime;
                                      context.read<DatesSelectCubit>().setDates(date, date);
                                    }
                                  },
                                ),
                                if (optionState == CalendarFormatOptions.hour)
                                  BlocBuilder<DatesSelectCubit, DatesSelectionEntity>(
                                    builder: (context, state) {
                                      return HourRangePickerWidget(
                                        startHour: state.startTime,
                                        endHour: state.endTime,
                                        blockedHours: ((calenderState is CalendarSuccess)
                                            ? calenderState.unit
                                            : unit).calendars.where((e) {
                                          return e.startDate.isAtSameMomentAs(
                                              state.startDate ?? DateTime.now());
                                        }).map((e) {
                                          if (e.startDate.year == e.endDate.year &&
                                              e.startDate.month == e.endDate.month &&
                                              e.startDate.day == e.endDate.day) {
                                            final List<int> list = [];
                                            for (int i = e.startDate.hour; i <= e.endDate.hour; i++) {
                                              list.add(i);
                                            }
                                            return list;
                                          }
                                          return <int>[];
                                        }).expand((e) => e),
                                        onHourRangeChanged: (start, end) {
                                          context.read<DatesSelectCubit>().setTime(start, end);
                                        },
                                      );
                                    },
                                  ),
                                // const BodyText(text: "RangeCalendarSection")
                                // const RangeCalendarSection(),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: const Row(
                            children: [
                              OrderStatus(color: AppColors.black, title: 'متاح'),
                              OrderStatus(color: AppColors.cherryRed, title: 'محجوز'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.h),
                            child: Row(
                              children: [
                                Flexible(
                                  child: MaktabButton(
                                    text: 'اشغال',
                                    backgroundColor: AppColors.lightCyan,
                                    onPressed: calenderState is CalendarLoading
                                        ? null
                                        : () {
                                      final selectedDates = context
                                          .read<DatesSelectCubit>()
                                          .state;
                                      if (selectedDates.startDate != null) {
                                        final selectedTypeRes = context
                                            .read<CalendarSelectCubit>()
                                            .state;
                                        final priceID = unit.prices.firstWhere((e) {
                                          return e.typeRes?.arName ==
                                              TypeRes.getCalenderText(selectedTypeRes!);
                                        }).id;
                                        context.read<CalendarBloc>().add(
                                          SetOfficeCalendarsEvent(
                                            unit.id,
                                            priceID,
                                            [
                                              Calendar(
                                                startDate: selectedDates.startDate!.addHours(
                                                    selectedDates.startTime ?? 0),
                                                endDate: (selectedDates.endDate ?? selectedDates.startDate!)
                                                    .addHours(selectedDates.endTime ?? 23),
                                                adsId: unit.id,
                                                adsPriceId: priceID,
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 15.h),
                                Flexible(
                                  child: MaktabButton(
                                    text: 'اتاحة',
                                    backgroundColor: AppColors.slateGray,
                                    onPressed: calenderState is CalendarLoading
                                        ? null
                                        : () {
                                      final selectedDates = context
                                          .read<DatesSelectCubit>()
                                          .state;
                                      if (selectedDates.startDate != null) {
                                        context.read<CalendarBloc>().add(
                                          DeleteOfficeCalendarsEvent(
                                            unit.id,
                                            unit.calendars.where((e) {
                                              final selectedStart = selectedDates.startDate!.addHours(
                                                  selectedDates.startTime ?? 0);
                                              final selectedEnd =
                                              (selectedDates.endDate ?? selectedDates.startDate!).addHours(
                                                  selectedDates.endTime ?? 23);
                                              final isAfter =
                                                  e.startDate.isAfter(selectedStart) ||
                                                      e.startDate.isAtSameMomentAs(selectedStart);
                                              final isBefore = e.endDate.isBefore(selectedEnd) ||
                                                  e.endDate.isAtSameMomentAs(selectedEnd);
                                              return isAfter && isBefore;
                                            }).toList(),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}