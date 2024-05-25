// ignore_for_file: depend_on_referenced_packages
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_icon_item.dart';

class FileSelectorBox extends StatelessWidget {
  const FileSelectorBox({
    super.key,
    required this.title,
    required this.icon,
    this.fileWidget,
    this.height,
    this.width,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Widget? fileWidget;
  final double? height;
  final double? width;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 2.h),
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [3, 3],
          padding: EdgeInsets.zero,
          radius: Radius.circular(15.fSize),
          color: AppColors.smokeGray,
          child: fileWidget != null
              ? fileWidget!
              : Center(
                  child: MaktabIconItem(
                  title: title,
                  icon: icon,
                  color: AppColors.slateGray,
                )),
        ),
      ),
    );
  }
}
