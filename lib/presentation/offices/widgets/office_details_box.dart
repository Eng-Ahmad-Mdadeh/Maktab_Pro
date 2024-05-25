// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/colored_circle.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeDetailsBox extends StatelessWidget {
  const OfficeDetailsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.softAsh),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(title: 'معلومات المكتب'),
                      SizedBox(height: 15.v),
                      const BodyText(text: 'مدينة جدة حي اللؤلؤ'),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.smokeGray,
                  size: 17,
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.softAsh),
          Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.v),
                      child: const ColoredCircle(color: AppColors.emeraldTeal),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(title: 'الدعم الفني Maktab'),
                          SizedBox(height: 5.v),
                          const BodyText(text: 'ص الاثنين 12 ديسمبر 10:20'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'مرفوض',
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.cherryRed),
              )
            ],
          ),
        ],
      ),
    );
  }
}
