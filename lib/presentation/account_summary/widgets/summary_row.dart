import 'package:flutter/material.dart';

import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';

class SummaryRow extends StatelessWidget {
  final String title;
  final String text;
  final bool bigRow;
  final Color? textColor;

  const SummaryRow({
    super.key,
    required this.title,
    required this.text,
    this.bigRow = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return bigRow
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyText(text: title),
        SectionTitle(
          title: text,
          textColor: textColor,
          fontSize: 16,
          overflow: TextOverflow.visible,
        ),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BodyText(text: title),
        SectionTitle(
          title: text,
          textColor: textColor,
          fontSize: 16,
        ),
      ],
    );
  }
}