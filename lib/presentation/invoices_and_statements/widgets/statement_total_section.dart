// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_rich_text.dart';

import '../../widgets/section_title.dart';

class StatementTotalSection extends StatelessWidget {
  const StatementTotalSection({super.key, required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SectionTitle(
            title: 'اجمالي كشوف الحساب',
            textColor: AppColors.slateGray,
          ),
          MaktabRichText(
            texts: [
              MaktabRichTextModel(
                text: total,
                fontWeight: FontWeight.w500,
                color: AppColors.emeraldTeal,
              ),
              MaktabRichTextModel(
                text: 'ريال',
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
