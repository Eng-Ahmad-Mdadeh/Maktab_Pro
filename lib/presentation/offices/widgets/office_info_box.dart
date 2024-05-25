import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeInfoBox extends StatelessWidget {
  const OfficeInfoBox({
    super.key,
    required this.title,
    this.enableEdit = true,
    this.editOnTap,
    required this.infoWidget,
  });

  final String title;
  final bool enableEdit;
  final Function()? editOnTap;
  final Widget infoWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeHelper.width,
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.softAsh),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionTitle(title: title),
              if (enableEdit)
                InkWell(
                  onTap: editOnTap,
                  child: const BodyText(
                    text: 'تعديل',
                    textColor: AppColors.mintTeal,
                  ),
                ),
            ],
          ),
          SizedBox(height: 15.v),
          Align(alignment: Alignment.centerRight, child: infoWidget),
        ],
      ),
    );
  }
}
