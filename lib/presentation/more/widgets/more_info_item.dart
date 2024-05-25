import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

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
            Expanded(
              child: Text(
                '0/2',
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(height: 10.v),
            Expanded(
              child: Text(
                title,
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
