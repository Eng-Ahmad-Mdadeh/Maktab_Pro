// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'contract_item.dart';

class ContractDetailsBox extends StatelessWidget {
  const ContractDetailsBox({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 1,
      child: ExpansionTile(
        collapsedIconColor: AppColors.black,
        iconColor: AppColors.black,
        title: Text(
          title,
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(20.v),
            child: Column(
              children: [
                const ContractItem(
                  title: 'الطلبات',
                  amount: '300',
                ),
                SizedBox(height: 10.v),
                const ContractItem(
                  title: 'المبيعات',
                  amount: '0.0',
                ),
                SizedBox(height: 10.v),
                const ContractItem(
                  title: 'العمولات',
                  amount: '300',
                ),
                SizedBox(height: 10.v),
                const ContractItem(
                  title: 'الضريبة المضافة',
                  amount: '300',
                ),
                SizedBox(height: 10.v),
                const ContractItem(
                  title: 'العرابين',
                  amount: '300',
                ),
                SizedBox(height: 10.v),
                const ContractItem(
                  title: 'المستحق',
                  amount: '300',
                ),
                SizedBox(height: 20.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text('الفاتورة',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: Theme.of(context).textTheme.titleSmall!),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text('كشف الحساب',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: Theme.of(context).textTheme.titleSmall!),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
