// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    elevation: const MaterialStatePropertyAll(0),
    backgroundColor: const MaterialStatePropertyAll<Color>(AppColors.mintTeal),
    shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(),
    ),
    minimumSize: MaterialStatePropertyAll<Size>(
      Size(double.infinity, 60.v),
    ),
  ),
);
