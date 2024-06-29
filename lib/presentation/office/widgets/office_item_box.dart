import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';

import '../../widgets/section_title.dart';

class OfficeItemBox extends StatelessWidget {
  const OfficeItemBox({
    super.key,
    required this.title,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    this.borderColor,
    required this.iconColor,
    this.gradient,
  });

  final String title;
  final String? icon;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final Color? iconColor;
  final Function() onTap;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: (SizeHelper.width * .3) - 20.h,
        height: (SizeHelper.width * .3) - 20.h,
        padding: EdgeInsets.symmetric(vertical: 14.v, horizontal: 7.h),
        margin: EdgeInsets.only(left: 10.0.h, bottom: 10.0.v),
        decoration: BoxDecoration(
          // color: backgroundColor,
          borderRadius: BorderRadius.circular(7.0.adaptSize),
          border: Border.all(color: borderColor??AppColors.slateGray),
          gradient: gradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (icon != null)
              MaktabImageView(
                imagePath: icon!,
                width: 30.0.h,
                height: 30.0.v,
                color: iconColor,
              ),
            SectionTitle(
              title: title,
              textAlign: TextAlign.center,
              textColor: textColor,
              textFontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ],
        ),
      ),
    );
  }
}
