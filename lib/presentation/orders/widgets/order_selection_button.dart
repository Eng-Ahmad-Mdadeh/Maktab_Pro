import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';

class OrderSelectionButton extends StatelessWidget {
  const OrderSelectionButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSelected,
  });

  final String title;
  final bool isSelected;
  final void Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return MaktabButton(
      text: title,
      width: 100.h,
      padding: EdgeInsets.zero,
      fontWeight: FontWeight.w700,
      color: AppColors.steelBlue,
      backgroundColor: AppColors.softAsh,
      isBordered: isSelected ? true : false,
      borderColor: isSelected ? AppColors.skyBlue : AppColors.black,
      onPressed: onSelected,
    );
  }
}
