import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';

class PriceSelectBox extends StatelessWidget {
  const PriceSelectBox({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.h),
        padding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 20.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.softAsh : AppColors.palePlatinum,
          borderRadius: BorderRadius.circular(15.adaptSize),
        ),
        child: Center(
          child: BodyText(
            text: title,
            textColor: isSelected ? AppColors.cherryRed : AppColors.slateGray,
          ),
        ),
      ),
    );
  }
}
