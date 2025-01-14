
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

import '../../widgets/section_title.dart';

class OfficeInfoCard extends StatelessWidget {
  const OfficeInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: SizeHelper.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10.h),
          child: Row(
            children: [
              Container(
                height: 90.v,
                width: 90.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.slateGray),
                ),
              ),
              SizedBox(width: 15.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    title:
                    "111111",
                  ),
                  SizedBox(height: 6.v),
                  const SectionTitle(
                    title:
                    'الاجراءات المكتملة',textColor: AppColors.slateGray

                  ),
                  SizedBox(height: 6.v),
                  Row(
                    children: [
                      SizedBox(
                        height: 10.v,
                        width: 95.h,
                        child: const ClipRRect(
                          child: LinearProgressIndicator(value: 1),
                        ),
                      ),
                      SizedBox(width: 8.h),
                      const SectionTitle(
                        title:
                        "6/3",textColor: AppColors.cherryRed

                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
