// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitInfoItem extends StatelessWidget {
  const UnitInfoItem({super.key, required this.unit, required this.onPressed});

  final Office unit;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: unit.title??''),
              SizedBox(height: 6.v),
              const BodyText(text: 'الاجراءات المكتملة'),
              SizedBox(height: 6.v),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: LinearProgressIndicator(
                      value: Office.getUnitCompleteStepsCount(unit).toDouble() / 6,
                      minHeight: 12.v,
                      borderRadius: BorderRadius.circular(10.adaptSize),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.lightCyan),
                    ),
                  ),
                  SizedBox(width: 8.h),
                  Expanded(
                    child: BodyText(
                      text: "${Office.getUnitCompleteStepsCount(unit)}/6",
                      textColor: AppColors.cherryRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        MaktabButton(
          height: 35.v,
          width: 90.0.h,
          text: 'استكمال',
          fontSize: 13.0,
          color: AppColors.emeraldTeal,
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.white,
          isBordered: true,
          borderColor: AppColors.emeraldTeal,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
