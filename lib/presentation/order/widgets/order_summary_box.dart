import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/order/widgets/order_info_item.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class OrderSummaryBox extends StatelessWidget {
  const OrderSummaryBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'ملخص الطلب'),
          SizedBox(height: 12.v),
          const OrderInfoItem(
            title: 'الاسم',
            text: 'وائل الديري',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'رقم الاثبات',
            text: 'الاثنين نوفمبر 2023 ',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'المجموع',
            amount: '3300',
            text: 'ريال',
          ),
        ],
      ),
    );
  }
}
