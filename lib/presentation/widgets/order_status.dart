// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, required this.color, required this.title});

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.v, horizontal: 7.h),
      child: Row(
        children: [
          Container(
            width: 20.h,
            height: 20.v,
            decoration: ShapeDecoration(
              color: color,
              shape: const CircleBorder(),
            ),
          ),
          SizedBox(width: 5.h),
          Text(
            title,
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.smokeGray,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
