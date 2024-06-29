import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/order/widgets/order_info_item.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

import '../../../data/models/order/order_model.dart';

class GuestDataBox extends StatelessWidget {
  const GuestDataBox({super.key, this.order});

  final OrderModel? order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'بيانات الضيف'),
          SizedBox(height: 12.v),
          OrderInfoItem(
            title: 'الاسم',
            text: order?.tenant?.username??'',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'رقم الاثبات',
            text: '2233445',
          ),
        ],
      ),
    );
  }
}
