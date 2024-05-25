import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';

class LicenseRegisterDialog extends StatelessWidget {
  const LicenseRegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        'هل ترغب في التسجيل لدى الهيئة العامة للعقارات للحصول على ترخيص للوساطة العقارية والتسويق',
        textAlign: TextAlign.center,
        softWrap: true,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 20),
      actions: [
        MaktabButton(
          text: 'أوافق',
          color: AppColors.emeraldGreen,
          backgroundColor: AppColors.white,
          isBordered: true,
          borderColor: AppColors.emeraldGreen,
          onPressed: () {},
        ),
        MaktabButton(
          text: 'لاحقا',
          color: AppColors.cherryRed,
          backgroundColor: AppColors.white,
          isBordered: true,
          borderColor: AppColors.cherryRed,
          onPressed: () {},
        ),
      ],
    );
  }
}
