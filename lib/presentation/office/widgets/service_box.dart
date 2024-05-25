import 'package:flutter/material.dart';
import 'package:maktab/data/models/office/office_service_model.dart';
import 'package:maktab/presentation/office/widgets/office_item_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class ServiceBox extends StatelessWidget {
  const ServiceBox({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  final OfficeService service;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OfficeItemBox(
      title: service.arName,
      backgroundColor: isSelected ? AppColors.lightCyan : AppColors.white,
      textColor: isSelected ? AppColors.white : AppColors.smokeGray,
      onTap: onTap,
    );
  }
}
