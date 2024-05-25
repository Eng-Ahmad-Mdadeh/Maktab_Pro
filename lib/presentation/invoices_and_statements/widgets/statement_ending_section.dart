// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class StatementEndingSection extends StatelessWidget {
  const StatementEndingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نهاية طلب الحساب',
            softWrap: true,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.slateGray,
                ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Text(
              'تعتبر طلبات الحساب صحيحة مالم تستلم اعتراض خلال 15 يوم من تاريخ وصولها',
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
