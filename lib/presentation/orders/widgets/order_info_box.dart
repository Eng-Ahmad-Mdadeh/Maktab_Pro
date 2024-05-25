import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

class OrderInfoBox extends StatelessWidget {
  const OrderInfoBox({super.key, required this.status});

  final int status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppRoutes.orderScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.softAsh),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: const [0.03, 0.03],
            colors: [getColorFromStatus(status), Colors.white],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'علي',
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    children: [
                      TextSpan(
                        text: '3000',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.emeraldTeal),
                      ),
                      WidgetSpan(child: SizedBox(width: 6.h)),
                      const TextSpan(text: 'ريال')
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.v),
            Text(
              'مكتب 1 (وحدة1)',
              softWrap: true,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.slateGray,
                  ),
            ),
            Text(
              'من الجمعة 12 نوفمبر الى السبت 13 نوفمبر',
              softWrap: true,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.slateGray,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorFromStatus(int status) {
    switch (status) {
      case 0:
        return AppColors.emeraldGreen;
      case 1:
        return AppColors.cherryRed;
      case 2:
        return AppColors.rustOrange;
      case 3:
        return AppColors.yellow;
      default:
        return AppColors.black;
    }
  }
}
