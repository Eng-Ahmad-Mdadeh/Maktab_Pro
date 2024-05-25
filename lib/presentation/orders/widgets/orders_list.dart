// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/order/order_model.dart';
import 'package:maktab/presentation/orders/widgets/order_info_box.dart';

class OrdersList extends StatelessWidget {
  OrdersList({super.key});

  List<OrderModel> orders = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => OrderInfoBox(
          status: int.parse(orders[index].status??'0'),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 15.v),
        itemCount: orders.length,
      ),
    );
  }
}
