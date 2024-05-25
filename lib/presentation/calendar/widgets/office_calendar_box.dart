// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/presentation/calendar/widgets/unit_calendar_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeCalendarBox extends StatelessWidget {
  const OfficeCalendarBox({super.key, required this.office});

  final Office office;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.v,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: office.title),
          SizedBox(height: 20.v),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => UnitCalendarBox(
                unit: office.units[index],
              ),
              separatorBuilder: (context, index) => SizedBox(width: 25.h),
              itemCount: office.units.length,
            ),
          ),
          SizedBox(height: 15.v),
          const Divider(color: AppColors.softAsh),
        ],
      ),
    );
  }
}
