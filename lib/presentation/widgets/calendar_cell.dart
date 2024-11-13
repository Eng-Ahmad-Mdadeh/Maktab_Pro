import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/colored_circle.dart';

import 'section_title.dart';

class CalendarCell extends StatelessWidget {
  const CalendarCell({
    super.key,
    required this.date,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.lineThrough = false,
    this.isCircle = true,
    this.isAvailableDay = false,
    this.isHour = false,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
  });

  final DateTime date;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isCircle;
  final bool isAvailableDay;
  final bool isHour;
  final bool lineThrough;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.v),
            decoration: isCircle
                ? ShapeDecoration(
                    color: backgroundColor ?? AppColors.white,
                    shape: borderColor != null
                        ? CircleBorder(side: BorderSide(color: borderColor!))
                        : const CircleBorder(),
                  )
                : BoxDecoration(
                    color: backgroundColor ?? AppColors.white,
                    border: borderColor != null
                        ? Border.all(color: borderColor!)
                        : null,
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SectionTitle(
                    title:
                    isHour
                        ? date.hour < 10
                            ? '0${date.hour}:00'
                            : '${date.hour}:00'
                        : date.day.toString(),textColor: textColor,
                    // fontFamily: 'Roboto',
                    decoration:
                    lineThrough ? TextDecoration.lineThrough : null,
                    decorationColor: AppColors.black,

                  ),
                ),
                if (isHour)
                  BodyText(
                    text: date.hour < 12 ? 'AM' : 'PM',
                    textColor: textColor,
                  ),
              ],
            ),
          ),
          if (isAvailableDay)
            Align(
              alignment: Alignment.topLeft,
              child: ColoredCircle(
                color: AppColors.emeraldTeal,
                width: 10.h,
                height: 10.v,
              ),
            ),
        ],
      ),
    );
  }
}
