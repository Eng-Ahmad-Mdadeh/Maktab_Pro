import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({
    super.key,
    required this.title,
    required this.text,
    this.amount,
  });

  final String title;
  final String text;
  final String? amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.slateGray,
              ),
        ),
        RichText(
          text: TextSpan(
            children: [
              amount != null
                  ? TextSpan(
                      text: amount,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.emeraldTeal,
                          ),
                    )
                  : const WidgetSpan(child: SizedBox.shrink()),
              WidgetSpan(child: SizedBox(width: 5.h)),
              TextSpan(
                text: text,
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
