import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/category_aqar/category_aqar_model.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';

import '../../widgets/body_text.dart';

class OfficeCategoryBox extends StatelessWidget {
  const OfficeCategoryBox({
    super.key,
    required this.officeCategory,
    required this.onTap,
    required this.isSelected,
  });

  final CategoryAqar officeCategory;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60.h,
        height: 60.v,
        // padding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 15.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.royalSoftPurple : null,
          borderRadius: BorderRadius.circular(15),
          // border: isSelected ? Border.all(color: AppColors.cherryRed, width: 1) : null,
          gradient: isSelected ? null : const LinearGradient(
            colors: [
              AppColors.mintGreen,
              AppColors.royalPurple,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: MaktabImageView(
                width: 30.h,
                height: 30.v,
                imagePath: officeCategory.icon,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 10.0.v,),
            // Container(
            //   width: 100.h,
            //   height: 100.v,
            //   color: AppColors.black.withOpacity(.3),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BodyText(
                text: officeCategory.arName,
                textColor: AppColors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
