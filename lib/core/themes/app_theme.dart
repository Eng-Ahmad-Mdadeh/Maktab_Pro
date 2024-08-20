// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/themes/app_bar_theme.dart';
import 'package:maktab_lessor/core/themes/bottom_app_bar_theme.dart';
import 'package:maktab_lessor/core/themes/color_scheme.dart';
import 'package:maktab_lessor/core/themes/elevated_button_theme.dart';
import 'package:maktab_lessor/core/themes/input_decoration_theme.dart';
import 'package:maktab_lessor/core/themes/text_theme.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    iconTheme: const IconThemeData(
      color: AppColors.black
    ),
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomAppBarTheme: bottomAppBarTheme,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    datePickerTheme: const DatePickerThemeData(
      //surfaceTintColor: Colors.transparent,
      todayBackgroundColor: WidgetStatePropertyAll(AppColors.royalPurple),
      backgroundColor: AppColors.white
      //todayBorder: BorderSide(color: AppColors.royalPurple, width: 2),
    ),
    switchTheme: const SwitchThemeData(
      trackOutlineColor: WidgetStatePropertyAll(AppColors.slateGray),
      trackColor: WidgetStatePropertyAll(AppColors.white),
      thumbColor: WidgetStatePropertyAll(AppColors.slateGray),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: AppColors.slateGray,
      collapsedIconColor: AppColors.slateGray,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: AppColors.mintGreen,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark();
}
