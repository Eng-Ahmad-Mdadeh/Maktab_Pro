
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

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
