// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_rich_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class PeriodBalanceItem extends StatelessWidget {
  const PeriodBalanceItem({
    super.key,
    required this.title,
    required this.balance,
  });

  final String title;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: title,
          textColor: AppColors.slateGray,
        ),
        SizedBox(height: 5.v),
        MaktabRichText(
          texts: [
            MaktabRichTextModel(
              text: balance,
              color: AppColors.emeraldTeal,
              fontWeight: FontWeight.w500,
            ),
            MaktabRichTextModel(
              text: "ريال",
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }
}
