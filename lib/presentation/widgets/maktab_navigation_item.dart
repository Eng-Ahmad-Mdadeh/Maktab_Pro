// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class MaktabNavigationItemItem extends StatelessWidget {
  const MaktabNavigationItemItem({
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
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.slateGray,
        ),
      ),
    );
  }
}
