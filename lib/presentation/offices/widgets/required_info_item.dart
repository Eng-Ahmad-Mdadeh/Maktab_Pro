import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';

class RequiredInfoItem extends StatelessWidget {
  const RequiredInfoItem({super.key, required this.title, required this.onTap});

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.v),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.softAsh,
                  size: 45.fSize,
                ),
                SizedBox(width: 5.h),
                BodyText(text: title),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              'هنا',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.mintTeal,
                    fontFamily: 'Roboto',
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.mintTeal,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
