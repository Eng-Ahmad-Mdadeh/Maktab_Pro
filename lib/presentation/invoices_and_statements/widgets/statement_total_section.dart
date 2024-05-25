// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class StatementTotalSection extends StatelessWidget {
  const StatementTotalSection({super.key, required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'اجمالي كشوف الحساب',
            softWrap: true,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.slateGray,
                ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: total,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.emeraldTeal,
                      ),
                ),
                WidgetSpan(child: SizedBox(width: 5.h)),
                TextSpan(
                  text: 'ريال',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
