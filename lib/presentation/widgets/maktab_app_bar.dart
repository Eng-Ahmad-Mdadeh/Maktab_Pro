
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

import 'section_title.dart';

class MaktabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MaktabAppBar({
    super.key,
    this.leading,
    required this.title,
    this.titleColor,
    this.centerTitle = true,
    this.backgroundColor,
    this.actions,
    this.leadingWidth,
  });

  final String title;
  final Widget? leading;
  final Color? titleColor;
  final bool? centerTitle;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      leadingWidth: leadingWidth,
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
        child: SectionTitle(
          title: title,
          textColor: titleColor??AppColors.white,
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
