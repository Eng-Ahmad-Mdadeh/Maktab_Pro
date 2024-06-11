// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class DateItemBox extends StatelessWidget {
  const DateItemBox({
    super.key,
    required this.title,
    this.backgroundColor = AppColors.softAsh,
    this.textColor = AppColors.slateGray,
    required this.onTap,
  });

  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: SectionTitle(
            title: title,
              textColor: textColor
          ),
        ),
      ),
    );
  }
}
