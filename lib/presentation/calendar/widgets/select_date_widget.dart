import 'package:flutter/material.dart';
import 'package:maktab/core/extension/date_time_extension.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/models/calendar/calender_model.dart';
import '../../../data/models/offer/offer_model.dart';
import '../../resources/app_colors.dart';
import 'date_picker_cell.dart';

class SelectDateWidget extends StatelessWidget {
  final void Function(DateRangePickerSelectionChangedArgs)? onSelectionChanged;
  final bool Function(DateTime) selectableDayPredicate;
  final Offer? offer;
  final List<Calendar> calendars;
  final DateRangePickerController _controller;
  final bool isSingle;

  const SelectDateWidget(
      this._controller, {
        super.key,
        this.onSelectionChanged,
        required this.selectableDayPredicate,
        required this.offer,
        required this.calendars,
        this.isSingle = false,
      });

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      controller: _controller,
      minDate: DateTime.now(),
      onSelectionChanged: onSelectionChanged,
      selectionShape: DateRangePickerSelectionShape.circle,
      // selectableDayPredicate: selectableDayPredicate,
      backgroundColor: Colors.transparent,
      headerStyle: DateRangePickerHeaderStyle(
        backgroundColor: Colors.transparent,
        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),
      ),
      monthCellStyle: DateRangePickerMonthCellStyle(
        todayTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),
      ),
      monthViewSettings: DateRangePickerMonthViewSettings(
        viewHeaderStyle: DateRangePickerViewHeaderStyle(
          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),
        ),
      ),
      rangeSelectionColor: AppColors.mintGreen,
      selectionMode: isSingle ? DateRangePickerSelectionMode.single : DateRangePickerSelectionMode.range,
      yearCellStyle: DateRangePickerYearCellStyle(
        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),
        todayTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.black),
        todayCellDecoration: BoxDecoration(
          border: Border.all(
            color: AppColors.mintGreen,
          ),
          borderRadius: BorderRadius.circular(50.0.adaptSize),
        ),
      ),
      cellBuilder: (BuildContext context, DateRangePickerCellDetails cellDetails) {
        final DateTime date = cellDetails.date;
        final isDisabled = !selectableDayPredicate(date) || date.isBefore(DateTime.now());
        CellStyleType cellStyleType = CellStyleType.text;

        final startOrEndSelected = _controller.selectedRange?.startDate == date && _controller.selectedRange?.endDate == null;
        // // circle with offer
        if (startOrEndSelected) cellStyleType = CellStyleType.circle;
        final selectedSingleDate = _controller.selectedDate == date;
        // circle
        if (selectedSingleDate) cellStyleType = CellStyleType.circle;
        final startSelected = _controller.selectedRange?.startDate == date && _controller.selectedRange?.endDate != null;
        // right radius
        if (startSelected) cellStyleType = CellStyleType.rightRadius;
        final endSelected = _controller.selectedRange?.endDate == date && _controller.selectedRange?.startDate != null;
        // left radius
        if (endSelected) cellStyleType = CellStyleType.leftRadius;
        final dateInOfferRange = offer == null ? false : date.isInRangeWithSameDayR({'start': offer!.startDate, 'end': offer!.endDate});
        if (dateInOfferRange) cellStyleType = CellStyleType.textWithOffer;
        if (dateInOfferRange && startOrEndSelected) cellStyleType = CellStyleType.circleWithOffer;
        if (dateInOfferRange && selectedSingleDate) cellStyleType = CellStyleType.circleWithOffer;
        if (dateInOfferRange && startSelected) cellStyleType = CellStyleType.rightRadiusWithOffer;
        if (dateInOfferRange && endSelected) cellStyleType = CellStyleType.leftRadiusWithOffer;
        if (_controller.selectedRange?.startDate != null && _controller.selectedRange?.endDate != null && !startSelected && !endSelected) {
          final dateInSelectedRange =
          date.isInRangeWithSameDayR({'start': _controller.selectedRange!.startDate!, 'end': _controller.selectedRange!.endDate!});
          if (dateInSelectedRange) cellStyleType = CellStyleType.textInRange;
          if (dateInOfferRange && dateInSelectedRange) cellStyleType = CellStyleType.textInRangeWithOffer;
        }

        switch (_controller.view) {
          case null:
          case DateRangePickerView.month:
            return DatePickerCell(
              date: date,
              isDisabled: isDisabled,
              offer: offer,
              cellStyleType: cellStyleType,
            );
        // month name
          case DateRangePickerView.year:
            return DatePickerCell(
              date: date,
              isDisabled: isDisabled,
              offer: offer,
              cellStyleType: CellStyleType.monthName,
            );
        // text year
          case DateRangePickerView.decade:
            return DatePickerCell(
              date: date,
              isDisabled: isDisabled,
              offer: offer,
              cellStyleType: CellStyleType.textYear,
            );
        // year range
          case DateRangePickerView.century:
            return DatePickerCell(
              date: date,
              isDisabled: isDisabled,
              offer: offer,
              cellStyleType: CellStyleType.yearRange,
            );
        }
      },
    );
  }
}

