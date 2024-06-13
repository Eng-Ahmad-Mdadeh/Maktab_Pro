import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/network/api_endpoints.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';

class OfficeItemBox extends StatelessWidget {
  const OfficeItemBox({
    super.key,
    required this.title,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  final String title;
  final String? icon;
  final Color backgroundColor;
  final Color textColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120.h,
        padding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 15.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.slateGray),
        ),
        child: Column(
          children: [
            if (icon != null)
              Flexible(
                child: Column(
                  children: [
                    Flexible(child: Center(child: MaktabImageView(imagePath: icon!))),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            Flexible(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
