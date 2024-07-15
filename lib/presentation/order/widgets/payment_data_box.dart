import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/order/widgets/order_info_item.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class PaymentDataBox extends StatelessWidget {
  const PaymentDataBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'بيانات الدفع'),
          SizedBox(height: 12.v),
          const OrderInfoItem(
            title: 'طريقة الدفع',
            text: 'نقدي',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'المتبقي من الضيف',
            amount: '0.0',
            text: 'ريال ',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'المدفوع',
            amount: '300',
            text: 'ريال',
          ),
          SizedBox(height: 10.v),
          const OrderInfoItem(
            title: 'المجموع',
            amount: '3000',
            text: 'ريال',
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
