// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/order/order_model.dart';
import 'package:maktab_lessor/domain/home/home_bloc.dart';
import 'package:maktab_lessor/presentation/home/widgets/order_list_item.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class LatestOrdersCard extends StatelessWidget {
  LatestOrdersCard({super.key});

  OrderModel? order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: SizeHelper.width,
        padding: EdgeInsets.symmetric(vertical: 20.v, horizontal: 20.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Icon(
                    Icons.assignment_turned_in_outlined,
                    color: AppColors.softAsh,
                    size: 35.adaptSize,
                  ),
                  SizedBox(width: 10.h),
                  const SectionTitle(title: 'آخر الطلبات'),
                ],
              ),
            ),
            SizedBox(height: 10.v),
            context.read<HomeBloc>().state.statistics != null &&
                    context.read<HomeBloc>().state.statistics!.orders.isNotEmpty
                ? Column(
                  children:
                  List.generate(min(5, context.read<HomeBloc>().state.statistics!.orders.length), (index) {
                    order = context.read<HomeBloc>().state.statistics!.orders[index];
                    return OrderListItem(order: order!);
                  },)
                )
                : Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.v),
                      child: const BodyText(text: 'لا يوجد بيانات'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
