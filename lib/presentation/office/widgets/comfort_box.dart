import 'package:flutter/material.dart';
import 'package:maktab/data/models/comfort/comfort_model.dart';
import 'package:maktab/presentation/office/widgets/office_item_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class ComfortBox extends StatelessWidget {
  const ComfortBox({
    super.key,
    required this.comfort,
    required this.isSelected,
    required this.onTap,
  });

  final Comfort comfort;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OfficeItemBox(
      title: comfort.arName,
      icon: comfort.icon,
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
