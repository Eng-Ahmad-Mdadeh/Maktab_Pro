import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../resources/app_colors.dart';
import 'money_transfer_item.dart';

class TransferMoneyCard extends StatelessWidget {
  const TransferMoneyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.v),
      child: Card(
        color: AppColors.white,
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(20.v),
          child: Column(
            children: [
              const MoneyTransferItem(
                title: 'رقم الحوالة',
                text: '12345nf',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'تاريخ التنفيذ',
                text: '15 نوفمبر 2022 ',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'تاريخ الإنشاء',
                text: '15 نوفمبر 2022',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'طريقة التحويل',
                text: 'stc pay',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'رقم الجوال محول له',
                text: '054000000',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'عدد الطلبات',
                text: 'طلب واحد',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'رسوم التحويل',
                text: '0.5%',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'مبلغ الاستحقاق',
                text: '15000000 ر.س',
                amount: '300',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'صافي المبلغ المحول',
                text: '15000000 ر.س',
                amount: '1200',
              ),
              SizedBox(height: 10.v),
              const MoneyTransferItem(
                title: 'المبلغ المتبقي',
                text: '15000000 ر.س',
                amount: '450',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
