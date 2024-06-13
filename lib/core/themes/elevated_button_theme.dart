// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: const WidgetStatePropertyAll<Color>(AppColors.mintTeal),
    shape: const WidgetStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(),
    ),
    minimumSize: WidgetStatePropertyAll<Size>(
      Size(double.infinity, 60.v),
    ),
  ),
);
