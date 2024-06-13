// ignore_for_file: depend_on_referenced_packages

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

import '../../../core/themes/text_theme.dart';
import '../../../data/models/aqar_filter/type_res.dart';
import '../../../domain/calendar/calendar_select_cubit.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key, required this.unit});

  final Office unit;

  // final List<Map<String, dynamic>> dateFormats = [
  //   {'title': 'يومي', 'format': CalendarFormatOptions.day},
  //   {'title': 'ساعي', 'format': CalendarFormatOptions.hour},
  // ];

  @override
  Widget build(BuildContext context) {
    print(unit.prices);
    if (unit.prices.isEmpty) {
      return const Center(
        child: SectionTitle(
          title: "يرجى اضافة سعر في صفحة الاسعار الاساسية",
        ),
      );
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'العنوان:'),
            SizedBox(width: 10.h),
            Flexible(
              child: BodyText(text: '${unit.location?.city} - ${unit.location?.neighborhood} - ${unit.location?.street}'),
            ),
          ],
        ),
        SizedBox(height: 10.v),
        BlocBuilder<CalendarSelectCubit, CalendarFormatOptions?>(
          builder: (context, state) {
            print(state);
            if (unit.prices.length == 1) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.black.withOpacity(.2),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: EdgeInsets.all(15.0.adaptSize),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(width: 10.0.h,),
                    BodyText(
                      text: unit.prices.first.typeRes?.arName ?? '',
                      textColor: AppColors.slateGray,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.slateGray,
                      size: 25,
                    ),
                    // SizedBox(width: 10.0.h,),
                  ],
                ),
              );
            }
            return DropdownButtonFormField2<CalendarFormatOptions>(
              value: state,
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
              items: unit.prices
                  .map((p) => <String, dynamic>{'title': p.typeRes?.arName ?? '', 'format': TypeRes.getCalenderFormat(p.typeRes?.arName ?? '')})
                  .map((format) {
                return DropdownMenuItem<CalendarFormatOptions>(
                  value: format['format'],
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      format['title'],
                      style: textTheme.bodyLarge,
                    ),
                  ),
                );
              }).toList(),
              decoration: (const InputDecoration()).applyDefaults(Theme.of(context).inputDecorationTheme),
              onChanged: (value) {
                context.read<CalendarSelectCubit>().changed(value!);
              },
            );
          },
        ),
      ],
    );
  }
}
