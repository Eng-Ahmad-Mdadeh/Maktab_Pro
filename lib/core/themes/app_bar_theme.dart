// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

final AppBarTheme appBarTheme = AppBarTheme(
  elevation: 0.0,
  centerTitle: true,
  backgroundColor: AppColors.deepBlue,
  titleTextStyle: TextStyle(
    color: AppColors.white,
    fontSize: 25.fSize,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w700,
  ),
);
