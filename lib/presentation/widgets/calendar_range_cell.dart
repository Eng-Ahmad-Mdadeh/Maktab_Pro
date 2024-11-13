
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';

class CalendarRangeCell extends StatelessWidget {
  const CalendarRangeCell({
    super.key,
    required this.date,
    this.hourMode = false,
    this.isBeforeDate = false,
    this.isRangeStart = false,
    this.isRangeEnd = false,
    this.onTap,
  });

  final DateTime date;
  final bool hourMode;
  final bool isBeforeDate;
  final bool isRangeStart;
  final bool isRangeEnd;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: isRangeStart
          ? Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    margin: EdgeInsets.only(right: constraints.maxWidth / 2),
                    decoration: BoxDecoration(
                      color: isBeforeDate
                          ? AppColors.palePurple.withOpacity(0.5)
                          : AppColors.palePurple,
                    ),
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
                    color: hourMode
                        ? AppColors.palePurple
                        : isBeforeDate
                            ? AppColors.palePurple
                            : AppColors.lightCyan,
                    shape: const CircleBorder(),
                  ),
                  child: hourMode
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: BodyText(
                                text: hourMode
                                    ? date.hour < 10
                                        ? '0${date.hour}:00'
                                        : '${date.hour}:00'
                                    : date.day.toString(),
                                textColor: AppColors.black,
                              ),
                            ),
                            if (hourMode)
                              BodyText(
                                text: date.hour < 12 ? 'AM' : 'PM',
                                textColor: AppColors.black,
                              ),
                          ],
                        )
                      : Center(
                          child: BodyText(
                            text:
                            date.day.toString(),textColor: AppColors.white

                          ),
                        ),
                ),
              ],
            )
          : LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: SizeHelper.width,
                decoration: BoxDecoration(
                  color: isBeforeDate
                      ? AppColors.palePurple.withOpacity(0.5)
                      : AppColors.palePurple,
                  borderRadius: isRangeEnd
                      ? BorderRadius.only(
                          topLeft: Radius.circular(constraints.maxWidth / 2),
                          bottomLeft: Radius.circular(constraints.maxWidth / 2),
                        )
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: BodyText(
                        text: hourMode
                            ? date.hour < 10
                                ? '0${date.hour}:00'
                                : '${date.hour}:00'
                            : date.day.toString(),
                        textColor: AppColors.black,
                      ),
                    ),
                    if (hourMode)
                      BodyText(
                        text: date.hour < 12 ? 'AM' : 'PM',
                        textColor: AppColors.black,
                      ),
                  ],
                ),
              );
            }),
    ).animate().fadeIn();
  }
}
