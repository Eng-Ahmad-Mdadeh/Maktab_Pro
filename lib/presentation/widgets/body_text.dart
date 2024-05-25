// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class BodyText extends StatelessWidget {
  const BodyText({
    super.key,
    required this.text,
    this.textAlign,
    this.textColor,
    this.fontFamily,
  });

  final String text;
  final TextAlign? textAlign;
  final Color? textColor;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: textColor ?? AppColors.slateGray,
            fontFamily: fontFamily,
          ),
    );
  }
}
