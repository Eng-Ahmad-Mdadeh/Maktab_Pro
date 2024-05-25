import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/presentation/order/widgets/guest_data_box.dart';
import 'package:maktab/presentation/order/widgets/order_data_box.dart';
import 'package:maktab/presentation/order/widgets/order_summary_box.dart';
import 'package:maktab/presentation/order/widgets/payment_data_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_bottom_app_bar.dart';
import 'package:maktab/presentation/widgets/shimmer_effect.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    context.read<ShimmerBloc>().add(BeginShimmerEffectEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: '2233445'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: BlocBuilder<ShimmerBloc, ShimmerState>(
            builder: (context, state) {
              return ShimmerEffect(
                isLoading: state is ShowShimmerEffectState,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.softAsh),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      GuestDataBox(),
                      Divider(color: AppColors.softAsh),
                      OrderDataBox(),
                      Divider(color: AppColors.softAsh),
                      PaymentDataBox(),
                      Divider(color: AppColors.softAsh),
                      OrderSummaryBox(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const MaktabBottomAppBar(),
    );
  }
}
