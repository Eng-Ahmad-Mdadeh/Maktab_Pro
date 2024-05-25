// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class AccountSummaryDetailsSection extends StatelessWidget {
  const AccountSummaryDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.v),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageTitle(title: 'شقة'),
              Icon(
                Icons.info_outline,
                color: AppColors.slateGray,
              ),
            ],
          ),
          SizedBox(height: 20.v),
          const BodyText(text: 'لا يوجد بيانات حاليا'),
        ],
      ),
    );
  }
}
