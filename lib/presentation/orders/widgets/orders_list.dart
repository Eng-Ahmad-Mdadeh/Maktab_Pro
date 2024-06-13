import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/order/order_model.dart';
import 'package:maktab/presentation/orders/widgets/order_info_box.dart';

class OrdersList extends StatelessWidget {
  const OrdersList(this._scrollController, {super.key, required this.orders, required this.moreOrderLoader});

  final ScrollController? _scrollController;
  final List<OrderModel> orders;
  final bool moreOrderLoader;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: ListView.separated(
        controller: _scrollController,
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if(moreOrderLoader){
            if(index == orders.length){
              return const Center(child: CircularProgressIndicator());
            }
          }
          return OrderInfoBox(
            order: orders[index],
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 15.v),
        itemCount: moreOrderLoader ? orders.length + 1 : orders.length,
      ),
    );
  }
}
