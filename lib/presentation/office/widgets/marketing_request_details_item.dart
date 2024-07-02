import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class MarketingRequestDetailsItem extends StatelessWidget {
  const MarketingRequestDetailsItem({
    super.key,
    required this.title,
    required this.fileName,
    required this.onTap,
  });

  final String title;
  final String fileName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        SizedBox(height: 10.v),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.h),
          decoration: BoxDecoration(
            color: AppColors.palePlatinum,
            borderRadius: BorderRadius.circular(15.v),
            border: Border.all(color: AppColors.slateGray),
          ),
          child: ListTile(
            onTap: onTap,
            contentPadding: EdgeInsets.zero,
            leading: MaktabButton(
              width: 110.h,
              height: 60.v,
              padding: EdgeInsets.zero,
              onPressed: onTap,
              text: 'اختر ملف',
              color: AppColors.white,
            ),
            title: BodyText(
              text: fileName.isEmpty
                  ? 'لم يتم إضافة ملف'
                  : fileName.split('/').last,
              textColor: AppColors.slateGray,
            ),
          ),
        ),
      ],
    );
  }
}
