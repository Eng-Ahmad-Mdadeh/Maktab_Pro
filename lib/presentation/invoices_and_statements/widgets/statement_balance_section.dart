
import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import 'period_balance_item.dart';

class StatementBalanceSection extends StatelessWidget {
  const StatementBalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PeriodBalanceItem(
            title: 'رصيد أول مدة',
            balance: '3000',
          ),
          PeriodBalanceItem(
            title: 'رصيد اخر مدة',
            balance: '3000',
          ),
        ],
      ),
    );
  }
}
