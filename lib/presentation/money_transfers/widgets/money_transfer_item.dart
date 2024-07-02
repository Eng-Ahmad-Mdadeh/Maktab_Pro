import 'package:flutter/material.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_rich_text.dart';

import '../../widgets/section_title.dart';

class MoneyTransferItem extends StatelessWidget {
  const MoneyTransferItem({
    super.key,
    required this.title,
    required this.text,
    this.amount = '',
  });

  final String title;
  final String text;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BodyText(text: title),
        amount.isNotEmpty
            ? MaktabRichText(
                texts: [
                  MaktabRichTextModel(
                    text: amount,
                    fontWeight: FontWeight.w500,
                    color: AppColors.emeraldTeal,
                  ),
                  MaktabRichTextModel(
                    text: 'ريال',
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  )
                ],
              )
            : SectionTitle(
                title: text,
                textAlign: TextAlign.center,
                textFontWeight: FontWeight.w500,
                textColor: AppColors.lightBlack,
              ),
      ],
    );
  }
}
