
import 'package:flutter/material.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

import 'section_title.dart';

class MaktabSnackbar {
  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(context, message, AppColors.emeraldTeal);
  }

  static void showWarning(BuildContext context, String message) {
    _showSnackbar(context, message, AppColors.yellow);
  }

  static void showError(BuildContext context, String message) {
    _showSnackbar(context, message, AppColors.cherryRed);
  }

  static void _showSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SectionTitle(
            title:
            message,
            textAlign: TextAlign.center,textColor: AppColors.white

          ),
        ),
      ),
    );
  }
}
