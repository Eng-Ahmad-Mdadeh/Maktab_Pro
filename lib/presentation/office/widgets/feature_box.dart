import 'package:flutter/material.dart';
import 'package:maktab/data/models/feature/feature_model.dart';
import 'package:maktab/presentation/office/widgets/office_item_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class FeatureBox extends StatelessWidget {
  const FeatureBox({
    super.key,
    required this.feature,
    required this.isSelected,
    required this.onTap,
  });

  final Feature feature;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OfficeItemBox(
      title: feature.arName,
      icon: feature.icon,
      backgroundColor: isSelected ? AppColors.lightCyan : AppColors.white,
      textColor: isSelected ? AppColors.white : AppColors.smokeGray,
      iconColor: isSelected ? AppColors.white : null,
      borderColor: isSelected ? AppColors.lightCyan : AppColors.slateGray,
      gradient: isSelected ? const LinearGradient(
        colors: [
          AppColors.mintGreen,
          AppColors.royalPurple,
        ],
      ) : null,
      onTap: onTap,
    );
  }
}
