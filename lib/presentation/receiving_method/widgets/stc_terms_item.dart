import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../resources/app_colors.dart';
import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';

class StcTermsItem extends StatelessWidget {
  const StcTermsItem({super.key, required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 45.h,
        height: 45.v,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.deepForestGreen,
        ),
        child: Center(
            child: SectionTitle(
          title: title,
          textColor: AppColors.white,
          textAlign: TextAlign.center,
        )),
      ),
      title: BodyText(
        text: text,
        textAlign: TextAlign.start,
      ),
    );
  }
}
