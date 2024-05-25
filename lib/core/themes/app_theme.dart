// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/themes/app_bar_theme.dart';
import 'package:maktab/core/themes/bottom_app_bar_theme.dart';
import 'package:maktab/core/themes/color_scheme.dart';
import 'package:maktab/core/themes/elevated_button_theme.dart';
import 'package:maktab/core/themes/input_decoration_theme.dart';
import 'package:maktab/core/themes/text_theme.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    bottomAppBarTheme: bottomAppBarTheme,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    datePickerTheme: const DatePickerThemeData(
      //surfaceTintColor: Colors.transparent,
      todayBackgroundColor: MaterialStatePropertyAll(AppColors.royalPurple),
      //todayBorder: BorderSide(color: AppColors.royalPurple, width: 2),
    ),
    switchTheme: const SwitchThemeData(
      trackOutlineColor: MaterialStatePropertyAll(AppColors.slateGray),
      trackColor: MaterialStatePropertyAll(AppColors.white),
      thumbColor: MaterialStatePropertyAll(AppColors.slateGray),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: AppColors.slateGray,
      collapsedIconColor: AppColors.slateGray,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark();
}
