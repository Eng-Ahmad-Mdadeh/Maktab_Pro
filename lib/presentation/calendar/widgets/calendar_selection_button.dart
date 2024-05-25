// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/calendar/calendar_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class CalendarSelectionButton extends StatelessWidget {
  const CalendarSelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.v, right: 20.h, left: 20.h),
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          return DropdownButton2(
            value: state.format,
            isDense: true,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            items: _buildDropdownItems(context),
            buttonStyleData: ButtonStyleData(
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.softAsh,
                ),
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: AppColors.slateGray,
                size: 25,
              ),
            ),
            onChanged: (value) {
              context
                  .read<CalendarBloc>()
                  .add(SelectCalendarFormatOptionEvent(value!));
            },
          );
        },
      ),
    );
  }

  List<DropdownMenuItem<CalendarFormatOptions>> _buildDropdownItems(
      BuildContext context) {
    return [
      _buildDropdownItem(context, CalendarFormatOptions.hour, 'ساعي'),
      _buildDropdownItem(context, CalendarFormatOptions.day, 'يومي'),
    ];
  }

  DropdownMenuItem<CalendarFormatOptions> _buildDropdownItem(
      BuildContext context, CalendarFormatOptions value, String label) {
    return DropdownMenuItem<CalendarFormatOptions>(
      value: value,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
