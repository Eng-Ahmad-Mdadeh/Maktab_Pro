import 'package:flutter/material.dart';

import '../../core/helpers/size_helper.dart';
import '../resources/app_text_styles.dart';

class BodyText extends StatelessWidget {
  const BodyText({
    super.key,
    required this.text,
    this.textAlign,
    this.textColor,
    this.fontSize,
    this.overflow,
    this.fontWeight,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
    this.maxLines,
  });

  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? fontSize;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.visible,
      maxLines: maxLines,
      style: AppTextStyles.bodyLarge.copyWith(
            color: textColor,
            fontSize: fontSize?.fSize ?? 15.0.fSize,
            fontWeight: fontWeight,
            decoration: decoration,
            decorationStyle: decorationStyle,
            decorationColor: decorationColor,
            decorationThickness: decorationThickness,
          ),
    );
  }
}
