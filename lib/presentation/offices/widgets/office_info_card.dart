// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

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
                  Text(
                    "111111",
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    'الاجراءات المكتملة',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.slateGray),
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
                      Text(
                        "6/3",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.cherryRed),
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
