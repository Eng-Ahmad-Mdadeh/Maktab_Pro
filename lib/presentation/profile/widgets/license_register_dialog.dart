import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';

import '../../widgets/section_title.dart';

class LicenseRegisterDialog extends StatelessWidget {
  const LicenseRegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const SectionTitle(
        title:
        'هل ترغب في التسجيل لدى الهيئة العامة للعقارات للحصول على ترخيص للوساطة العقارية والتسويق',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      // actionsPadding: const EdgeInsets.only(bottom: 20),
      actions: [
        Center(
          child: MaktabButton(
            text: 'أوافق',
            color: AppColors.emeraldGreen,
            backgroundColor: AppColors.white,
            isBordered: true,
            borderColor: AppColors.emeraldGreen,
            // todo: make sure what the action will be if agree
            onPressed: context.pop,
          ),
        ),
        SizedBox(height: 10.0.v,),
        Center(
          child: MaktabButton(
            text: 'لاحقا',
            color: AppColors.cherryRed,
            backgroundColor: AppColors.white,
            isBordered: true,
            borderColor: AppColors.cherryRed,
            onPressed: context.pop,
          ),
        ),
      ],
    );
  }
}
