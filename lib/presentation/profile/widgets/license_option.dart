import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/profile/widgets/license_register_dialog.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';

import '../../widgets/section_title.dart';

class LicenseOption extends StatelessWidget {
  const LicenseOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(
          title:
          'هل لديك ترخيص لممارسة الوساطة والتسويق العقاري؟',
        ),
        SizedBox(height: 10.v),
        SizedBox(
          height: 60.v,
          child: Row(
            children: [
              MaktabButton(
                text: 'نعم',
                width: 100.h,
                backgroundColor: AppColors.emeraldGreen,
                color: AppColors.white,
                padding: EdgeInsets.zero,
                isBordered: false,
                onPressed: () {},
              ),
              SizedBox(width: 10.h),
              MaktabButton(
                text: 'لا',
                width: 100.h,
                backgroundColor: AppColors.white,
                color: AppColors.black,
                padding: EdgeInsets.zero,
                isBordered: true,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const LicenseRegisterDialog();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
