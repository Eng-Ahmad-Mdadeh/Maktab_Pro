import 'package:flutter/material.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

import '../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../resources/app_colors.dart';
import '../../../../../../../widgets/maktab_image_view.dart';

class ContractButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color color;
  final Color? iconColor;
  final String? icon;
  final IconData? iconData;

  const ContractButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.iconColor,
    this.iconData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: color,
        padding: EdgeInsets.all(11.0.adaptSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SectionTitle(
              title: text,
              fontSize: 17.0,
              textColor: AppColors.white,
            ),
            SizedBox(
              width: 8.0.h,
            ),
            if(icon != null)
            MaktabImageView(
              imagePath: icon!,
              color: iconColor,
            ),
            if(iconData != null)
              Icon(iconData,
              color: iconColor,),
          ],
        ),
      ),
    );
  }
}