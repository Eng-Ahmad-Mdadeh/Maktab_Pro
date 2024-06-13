// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeItem extends StatelessWidget {
  const OfficeItem({
    super.key,
    required this.office,
    this.mode = 'add',
    required this.onTap,
  });

  final Office office;
  final String mode;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  title: office.title??'',
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 5.v),
                mode == 'add'
                    ? BodyText(
                        text: office.categoryAqar != null
                            ? office.categoryAqar!.arName
                            : '')
                    : BodyText(
                        text: DateFormatterHelper.getFormated(office.createdAt),
                      ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.slateGray,
          ),
        ],
      ),
    );
  }
}
