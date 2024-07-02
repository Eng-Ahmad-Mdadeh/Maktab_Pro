import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

import '../../widgets/section_title.dart';

class MoreInfoItem extends StatelessWidget {
  const MoreInfoItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.slateGray),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.slateGray,
              size: 30,
            ),
            SizedBox(height: 8.v),
            const Expanded(
              child: SectionTitle(
                title: '0/2',
              ),
            ),
            SizedBox(height: 10.v),
            Expanded(
              child: SectionTitle(
                title: title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
