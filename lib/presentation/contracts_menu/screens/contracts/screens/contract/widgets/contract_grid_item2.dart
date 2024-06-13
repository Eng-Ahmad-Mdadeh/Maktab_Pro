import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../../../../resources/app_colors.dart';
import '../../../../../../widgets/body_text.dart';
import '../../../../../../widgets/section_title.dart';

class ContractGridItem2 extends StatelessWidget {
  final String title;
  final String? value;
  final Color? color;

  const ContractGridItem2({super.key, required this.title, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0.adaptSize),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.0.adaptSize),
        border: Border.all(
          color: AppColors.black.withOpacity(.11),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            FontAwesomeIcons.building,
            color: AppColors.black,
            size: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BodyText(
               text: title,
                fontSize: 15.0,
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