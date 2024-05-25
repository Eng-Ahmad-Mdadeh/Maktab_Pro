// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class PeriodBalanceItem extends StatelessWidget {
  const PeriodBalanceItem({
    super.key,
    required this.title,
    required this.balance,
  });

  final String title;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          softWrap: true,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.slateGray,
              ),
        ),
        SizedBox(height: 5.v),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: balance,
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
    );
  }
}
