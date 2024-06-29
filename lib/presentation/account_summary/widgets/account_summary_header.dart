// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class AccountSummaryHeader extends StatelessWidget {
  const AccountSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SectionTitle(title: 'حدد الفترة'),
        SizedBox(width: 50.h),
        Expanded(
          child: MaktabButton(
            height: 55.v,
            padding: EdgeInsets.zero,
            backgroundColor: AppColors.softAsh,
            color: AppColors.black,
            text: 'ديسمبر 2023',
            icon: const Icon(
              Icons.calendar_month_rounded,
              color: AppColors.deepPurple,
            ),
            onPressed: () async {
              await showDatePicker(
                context: context,
                initialDatePickerMode: DatePickerMode.day,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2050, 12, 31),
              );
            },
          ),
        )
      ],
    );
  }
}
