import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/order/order_model.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.softAsh),
        borderRadius: BorderRadius.circular(10.adaptSize),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(vertical: 0.v, horizontal: 10.h),
        title: Row(
          children: [
            Expanded(
              child: BodyText(
                text: order.tenant?.username?.toString() ?? '',
                textColor: AppColors.lightBlack,
              ),
            ),
            Expanded(
              child: BodyText(
                text: DateFormatterHelper.getFormated(order.createdAt),
                textColor: AppColors.lightBlack,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        childrenPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(
                text: 'الحجز: ',
                textColor: AppColors.lightBlack,
              ),
              Expanded(
                child: BodyText(
                    text:
                        '${order.durationRes} ${OrderModel.getCounterReservationType(order.typeReservation??'')}'),
              ),
            ],
          ),
          SizedBox(height: 10.v),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(
                text: 'المبلغ: ',
                textColor: AppColors.lightBlack,
              ),
              Expanded(
                child: BodyText(text: '${order.totalPriceLessor} ريال'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
