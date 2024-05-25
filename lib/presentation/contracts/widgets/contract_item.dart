// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class ContractItem extends StatelessWidget {
  const ContractItem({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w500, color: AppColors.gray),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: amount,
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
        )
      ],
    );
  }
}
