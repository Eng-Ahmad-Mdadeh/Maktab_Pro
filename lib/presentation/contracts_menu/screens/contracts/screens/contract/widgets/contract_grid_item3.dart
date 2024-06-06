import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../resources/app_colors.dart';
import '../../../../../../widgets/text/body_text.dart';
import '../../../../../../widgets/text/section_title.dart';

class ContractGridItem3 extends StatelessWidget {
  final String title;
  final String? value;
  final Color? color;

  const ContractGridItem3({super.key, required this.title, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 23.h, left: 23.h, top: 20.0.v),
      padding: EdgeInsets.symmetric(vertical: 9.0.v),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.0.adaptSize),
        border: Border.all(
          color: AppColors.black.withOpacity(.11),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
            child: const Icon(
              FontAwesomeIcons.building,
              color: AppColors.black,
              size: 20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BodyText(
                title,
                fontSize: 15.0,
              ),
              SizedBox(
                height: 4.0.v,
              ),
              SectionTitle(
                title: value ?? '',
                fontSize: 14.0,
                textColor: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}