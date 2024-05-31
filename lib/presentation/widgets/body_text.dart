// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

import '../../core/themes/text_theme.dart';

class BodyText extends StatelessWidget {
  const BodyText({
    super.key,
    required this.text,
    this.textAlign,
    this.textColor,
    this.fontFamily,
    this.fontSize,
  });

  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final String? fontFamily;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      style: textTheme.titleSmall!.copyWith(
            color: textColor ?? AppColors.slateGray,
            fontFamily: fontFamily,
        fontSize: fontSize?.fSize ?? 18.fSize,
          ),
    );
  }
}
