// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';

class StatementEndingSection extends StatelessWidget {
  const StatementEndingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'نهاية طلب الحساب',
            textColor: AppColors.slateGray,
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: const BodyText(
                text: 'تعتبر طلبات الحساب صحيحة مالم تستلم اعتراض خلال 15 يوم من تاريخ وصولها',
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
