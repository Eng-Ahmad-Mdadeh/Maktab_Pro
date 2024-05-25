// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.textAlign,
    this.textColor,
    this.textFontWeight,
  });

  final String title;
  final TextAlign? textAlign;
  final Color? textColor;
  final FontWeight? textFontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.center,
      softWrap: true,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: textColor ?? AppColors.black,
            fontWeight: textFontWeight ?? FontWeight.bold,
          ),
    );
  }
}
