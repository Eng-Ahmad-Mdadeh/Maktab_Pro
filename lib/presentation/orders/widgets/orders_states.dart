import 'package:flutter/material.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/order_status.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';

class OrdersStates extends StatelessWidget {
  const OrdersStates({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.v,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          OrderStatus(color: AppColors.emeraldGreen, title: 'مقبول'),
          OrderStatus(color: AppColors.yellow, title: 'انتظار'),
          OrderStatus(color: AppColors.cherryRed, title: 'ملغي'),
        ],
      ),
    );
  }
}
