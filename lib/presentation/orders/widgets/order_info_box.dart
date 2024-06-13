import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_rich_text.dart';

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
                SectionTitle(
                  title: order.tenant?.username ?? '',
                ),
                MaktabRichText(
                  texts: [
                    MaktabRichTextModel(
                      text: order.totalPriceLessor?.toString() ?? '',
                      color: AppColors.emeraldTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0
                    ),
                    MaktabRichTextModel(
                      text: ' ريال',
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle(
                  title: order.office?.title ?? '',
                  textFontWeight: FontWeight.w500,
                  textColor: AppColors.slateGray,
                ),
                SectionTitle(title: '#${order.id}'),
              ],
            ),
            SectionTitle(
              title:
                  // 'من الجمعة 12 نوفمبر الى السبت 13 نوفمبر',
                  order.startDate?.toIso8601String().split('T').firstOrNull ?? '',
              textFontWeight: FontWeight.w500,
              textColor: AppColors.slateGray,
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
