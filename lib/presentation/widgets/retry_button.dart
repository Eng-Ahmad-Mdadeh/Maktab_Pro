// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

import 'section_title.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback onTap;

  const RetryButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onTap,
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SectionTitle(
                  title:
                  'حدث شيء ما بشكل خاطئ',textColor: AppColors.cherryRed
                ),
                const SectionTitle(
                  title:
                  'اعادة المحاولة',fontSize: 13,
                  decoration: TextDecoration.underline,

                ),
                Icon(
                  FontAwesomeIcons.repeat,
                  color: AppColors.softAsh,
                  size: 35.fSize,
                ),
              ]
                  .map((e) => Padding(
                        padding: EdgeInsets.all(11.0.adaptSize),
                        child: e,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
