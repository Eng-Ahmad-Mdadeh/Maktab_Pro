// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';

class DiscountButton extends StatelessWidget {
  const DiscountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaktabButton(
      height: 65.v,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.palePlatinum,
      text: 'الخصم الأسبوعي والشهري',
      icon: const Icon(
        Icons.calendar_month_rounded,
        color: AppColors.deepPurple,
        size: 30,
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
    );
  }
}
