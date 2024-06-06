// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class MaktabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MaktabAppBar({
    super.key,
    this.leading,
    required this.title,
    this.titleColor,
    this.centerTitle = true,
    this.backgroundColor,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final Color? titleColor;
  final bool? centerTitle;
  final Color? backgroundColor;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              AppColors.deepBlue,
              AppColors.mintGreen,
            ],
          ),
        ),
      ),
      leading: leading ??
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
              size: 25,
            ),
          ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                color: titleColor,
              ),
        ),
      ),
      titleSpacing: 0,
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(SizeHelper.width, 70.v);
}
