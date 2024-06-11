import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_rich_text.dart';

class UnitPriceText extends StatelessWidget {
  const UnitPriceText({super.key, required this.title, required this.price});

  final String title;
  final num price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.v),
      child: Row(
        children: [
          BodyText(text: title),
          MaktabRichText(
            texts: [
              MaktabRichTextModel(text: price.toString(), color: AppColors.lightBlack),
              MaktabRichTextModel(text: 'ريال', color: AppColors.emeraldTeal),
            ],
          ),
        ],
      ),
    );
  }
}
