import 'package:flutter/material.dart';

import '../../../core/helpers/size_helper.dart';
import '../../resources/app_text_styles.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
    this.textAlign,
    this.fontSize,
  });

  final String title;
  final TextAlign? textAlign;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.titleLarge.copyWith(fontSize: fontSize?.fSize ?? 25.0.fSize),
    );
  }
}
