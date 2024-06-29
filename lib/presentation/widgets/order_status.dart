// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

import 'section_title.dart';

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
          SectionTitle(
            title:
            title,
            textAlign: TextAlign.center,textColor: AppColors.smokeGray,
            textFontWeight: FontWeight.w500,

          ),
        ],
      ),
    );
  }
}
