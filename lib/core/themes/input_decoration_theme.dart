// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: AppColors.white,
  contentPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.v),
  errorStyle: TextStyle(
    color: AppColors.cherryRed,
    fontSize: 15.fSize,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.softAsh, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.softAsh, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.lightCyan, width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.cherryRed, width: 1),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.cherryRed, width: 1),
  ),
  hintStyle: TextStyle(
    color: AppColors.slateGray,
    fontSize: 18.fSize,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.w500,
  ),
);
