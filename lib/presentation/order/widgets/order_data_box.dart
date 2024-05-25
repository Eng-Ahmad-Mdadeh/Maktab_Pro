import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/order/widgets/order_info_item.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OrderDataBox extends StatelessWidget {
  const OrderDataBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'بيانات الطلب'),
          SizedBox(height: 12.v),
          const OrderInfoItem(
            title: 'رقم الحجز',
            text: '2233445',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'تاريخ انشاء الحجز',
            text: 'الاثنين نوفمبر 2023',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'العنوان',
            text: 'حديقة الفن',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'الوحدة',
            text: 'قاعة مناسبات صغيرة',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'تاريخ التحويل',
            text: 'الاثنين نوفمبر 2023',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'تاريخ المغادرة',
            text: 'الاثنين نوفمبر 2023',
          ),
        ],
      ),
    );
  }
}
