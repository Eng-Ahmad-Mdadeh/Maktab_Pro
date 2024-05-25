import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_category_model.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class OfficeCategoryBox extends StatelessWidget {
  const OfficeCategoryBox({
    super.key,
    required this.officeCategory,
    required this.onTap,
    required this.isSelected,
  });

  final OfficeCategory officeCategory;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60.h,
        height: 60.v,
        padding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: AppColors.cherryRed, width: 1)
              : null,
          gradient: RadialGradient(
            colors: [
              AppColors.royalPurple,
              AppColors.royalPurple.withOpacity(0.8),
              AppColors.royalPurple.withOpacity(0.7),
            ],
            stops: const [0, 0.8, 1],
            center: Alignment.center,
            radius: 0.55,
          ),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(imageUrl: officeCategory.icon),
            Text(
              officeCategory.arName,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
