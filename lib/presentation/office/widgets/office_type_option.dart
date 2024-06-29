import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OfficeTypeOption extends StatelessWidget {
  const OfficeTypeOption({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.trailing,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                leading,
                SizedBox(width: 15.h),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(right: 20.h),
                    decoration: const BoxDecoration(
                      border:
                          Border(right: BorderSide(color: AppColors.softAsh)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: title),
                        SizedBox(height: 10.v),
                        BodyText(text: subtitle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
