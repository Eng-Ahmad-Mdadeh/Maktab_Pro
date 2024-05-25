// ignore_for_file: depend_on_referenced_packages

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/calendar/calendar_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class CalendarHeader extends StatelessWidget {
  CalendarHeader({super.key, required this.unit});

  final Office unit;

  final List<Map<String, dynamic>> dateFormats = [
    {'title': 'يومي', 'format': CalendarFormatOptions.day},
    {'title': 'ساعي', 'format': CalendarFormatOptions.hour},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'العنوان:'),
            SizedBox(width: 10.h),
            Flexible(
              child: BodyText(
                  text:
                      '${unit.location!.city} - ${unit.location!.neighborhood} - ${unit.location!.street}'),
            ),
          ],
        ),
        SizedBox(height: 10.v),
        BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            return DropdownButtonFormField2(
              value: state.format,
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: AppColors.slateGray,
                  size: 25,
                ),
                openMenuIcon: Icon(
                  Icons.keyboard_arrow_up_sharp,
                  color: AppColors.slateGray,
                  size: 25,
                ),
              ),
              items: dateFormats.map((format) {
                return DropdownMenuItem<CalendarFormatOptions>(
                  value: format['format'],
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      format['title'],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                );
              }).toList(),
              decoration: (const InputDecoration())
                  .applyDefaults(Theme.of(context).inputDecorationTheme),
              onChanged: (value) {
                context
                    .read<CalendarBloc>()
                    .add(SelectCalendarFormatOptionEvent(value!));
              },
            );
          },
        ),
      ],
    );
  }
}
