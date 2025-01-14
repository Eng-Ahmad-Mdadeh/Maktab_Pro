
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/data/models/calendar/calender_model.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/resources/app_text_styles.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_calendar.dart';
import 'package:table_calendar/table_calendar.dart';


class UnitCalendarBox extends StatelessWidget {
  const UnitCalendarBox({super.key, required this.unit, required this.officeId});

  final Office unit;
  final int officeId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.h,
      child: InkWell(
        onTap: () {
          context.pushNamed(AppRoutes.unitCalendarScreen, extra: {'unitID': unit.id, 'officeID': officeId});
        },
        child: Column(
          children: [
            MaktabCalendar(
              onPressed: (){
                context.pushNamed(AppRoutes.unitCalendarScreen, extra: {'unitID': unit.id, 'officeID': officeId});
              },
              rowHeight: 25.v,
              headerVisible: true,
              titleTextStyle: AppTextStyles.bodyLarge.copyWith(color: AppColors.black),
              availableGestures: AvailableGestures.horizontalSwipe,
              width: SizeHelper.width * .3,
              month: DateTime.now().month,
              year: DateTime.now().year,
              selectedDates: unit.calendars
                  .expand((calendar) => Calendar.getDaysInBetween(calendar.startDate, calendar.endDate))
                  .toList(),
              defaultBuilder: (context, day, focusedDay) {
                return getCircleContainer(color: AppColors.gray);
              },
              todayBuilder: (context, day, focusedDay) {
                return getCircleContainer(
                    color: AppColors.white, border: const BorderSide(color: AppColors.lightCyan, width: 2));
              },
              selectedBuilder: (context, day, focusedDay) {
                return getCircleContainer(color: AppColors.lightCyan);
              },
            ),
            SizedBox(height: 15.v),
            Flexible(
              child: BodyText(text: unit.title ?? ''),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCircleContainer({required Color color, BorderSide? border}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.v),
      decoration: ShapeDecoration(
        color: color,
        shape: border != null
            ? CircleBorder(
                side: border,
              )
            : const CircleBorder(),
      ),
    );
  }
}
