import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';

class AccountTypeOption extends StatelessWidget {
  const AccountTypeOption({
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
    return MaktabButton(
      onPressed: onTap,
      backgroundColor: isSelected ? AppColors.black : AppColors.softAsh,
      color: AppColors.slateGray,
      padding: const EdgeInsets.all(4),
      text: title,
    );
  }
}
