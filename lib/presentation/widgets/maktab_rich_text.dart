import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../resources/app_text_styles.dart';

class MaktabRichTextModel {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Function()? onTap;

  MaktabRichTextModel({
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.onTap,
  });
}

class MaktabRichText extends StatelessWidget {
  final List<MaktabRichTextModel> texts;

  const MaktabRichText({
    super.key,
    required this.texts,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((e) => TextSpan(
          text: e.text,
          style: AppTextStyles.titleSmall.copyWith(
            color: e.color,
            fontSize: e.fontSize?.fSize ?? 15.0.fSize,
            fontWeight: e.fontWeight
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = e.onTap,
        )).toList(),
      ),
    );
  }
}
