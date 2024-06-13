import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_rich_text.dart';

import '../../widgets/section_title.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({
    super.key,
    required this.title,
    required this.text,
    this.amount,
  });

  final String title;
  final String text;
  final String? amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SectionTitle(
          title: title,
          textAlign: TextAlign.center,
          textFontWeight: FontWeight.w500,
          textColor: AppColors.slateGray,
        ),
        MaktabRichText(
          texts: [
            if (amount != null)
              MaktabRichTextModel(
                text: amount!,
                fontWeight: FontWeight.w500,
                color: AppColors.emeraldTeal,
              ),

            MaktabRichTextModel(
              text: text,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }
}
