import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/transfers/transfer_pagination_model.dart';

import '../../resources/app_colors.dart';
import 'money_transfer_item.dart';

class TransferMoneyCard extends StatelessWidget {
  final TransferModel model;

  const TransferMoneyCard({super.key, required this.model});

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
              MoneyTransferItem(
                title: 'رقم الحوالة',
                text: model.transferNumber,
              ),
              SizedBox(height: 10.v),
              MoneyTransferItem(
                title: 'تاريخ التنفيذ',
                text: model.executionDate.toString().split(' ').first,
              ),
              SizedBox(height: 10.v),
              MoneyTransferItem(
                title: 'تاريخ الإنشاء',
                text: model.createdAt.toString().split(' ').first,
              ),
              SizedBox(height: 10.v),
              MoneyTransferItem(
                title: 'طريقة التحويل',
                text: model.transferMethod,
              ),
              SizedBox(height: 10.v),
              MoneyTransferItem(
                title: 'رقم الجوال محول له',
                text: model.receiverMobile,
              ),
              SizedBox(height: 10.v),
              MoneyTransferItem(
                title: 'عدد الطلبات',
                text: model.numOrder,
              ),
              SizedBox(height: 10.v),
              MoneyTransferItem(
                title: 'رسوم التحويل',
                text: model.transferFeesRate != '0'
                    ? '${model.transferFeesRate}%'
                    : '${model.transferFeesValue}ريال',
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
