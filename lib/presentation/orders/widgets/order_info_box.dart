import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

import '../../../data/models/order/order_model.dart';
import '../../../domain/orders/order/order_bloc.dart';
import '../../widgets/section_title.dart';

class OrderInfoBox extends StatelessWidget {
  const OrderInfoBox({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<OrderBloc>().add(GetOrderEvent(order.id));
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
            colors: [getColorFromStatus(order.reservation), Colors.white],
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
                  order.tenant?.username ?? '',
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
                        text: order.totalPriceLessor?.toString() ?? '',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.emeraldTeal),
                      ),
                      WidgetSpan(child: SizedBox(width: 6.h)),
                      const TextSpan(text: 'ريال')
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.office?.title??'',
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.slateGray,
                  ),
                ),
                SectionTitle(title: '#${order.id}'),

              ],
            ),
            Text(
              // 'من الجمعة 12 نوفمبر الى السبت 13 نوفمبر',
              order.startDate?.toIso8601String().split('T').firstOrNull??'',
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

  Color getColorFromStatus(String? status) {
    switch (status) {
      case 'acceptably':
        return AppColors.emeraldGreen;
      case 'canceled':
        return AppColors.cherryRed;
      case 'new':
        return AppColors.rustOrange;
      case 'pending':
        return AppColors.yellow;
      case 'complete':
        return AppColors.skyBlue;
      default:
        return AppColors.black;
    }
  }
}
