import 'package:flutter/material.dart';
import 'package:maktab_lessor/data/models/facility/facility_model.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_item_box.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

class FacilityBox extends StatelessWidget {
  const FacilityBox({
    super.key,
    required this.facility,
    required this.isSelected,
    required this.onTap,
  });

  final Facility facility;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OfficeItemBox(
      title: facility.arName,
      icon: facility.icon,
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
