import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/order/widgets/order_info_item.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class GuestDataBox extends StatelessWidget {
  const GuestDataBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'بيانات الضيف'),
          SizedBox(height: 12.v),
          const OrderInfoItem(
            title: 'الاسم',
            text: 'وائل الديري',
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
