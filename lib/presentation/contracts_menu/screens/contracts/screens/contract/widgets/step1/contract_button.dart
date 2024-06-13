import 'package:flutter/material.dart';

import '../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../resources/app_colors.dart';
import '../../../../../../../widgets/maktab_image_view.dart';
import '../../../../../../../widgets/body_text.dart';

class ContractButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color color;
  final String? icon;

  const ContractButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          color: color,
          padding: EdgeInsets.all(11.0.adaptSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BodyText(
                text: text,
                fontSize: 14.0,
                textColor: AppColors.white,
              ),
              SizedBox(
                width: 8.0.h,
              ),
              if(icon != null)
              MaktabImageView(
                imagePath: icon!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}