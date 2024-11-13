
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

import '../../widgets/section_title.dart';

class MonthlyAccountStatementBox extends StatelessWidget {
  const MonthlyAccountStatementBox({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.white,
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.v, horizontal: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SectionTitle(
                  title: title,
                ),
              ),
              const Icon(
                textDirection: TextDirection.ltr,
                Icons.arrow_back_ios,
                color: AppColors.slateGray,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
