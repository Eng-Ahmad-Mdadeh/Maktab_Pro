import 'package:flutter/material.dart';

import '../../../core/helpers/size_helper.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.textAlign,
    this.textColor,
    this.fontSize,
    this.overflow,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
  });

  final String title;
  final TextAlign? textAlign;
  final Color? textColor;
  final double? fontSize;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      softWrap: true,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: AppTextStyles.titleMedium.copyWith(
        color: textColor ?? AppColors.black,
        fontWeight: FontWeight.bold,
        fontSize: fontSize?.fSize ?? 20.0.fSize,
        decoration: decoration,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      ),
    );
  }
}
