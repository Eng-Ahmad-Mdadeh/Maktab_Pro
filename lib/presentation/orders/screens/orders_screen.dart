import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/orders/widgets/orders_search_box.dart';
import 'package:maktab/presentation/orders/widgets/orders_list.dart';
import 'package:maktab/presentation/orders/widgets/orders_states.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/loading_widget.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';

import '../../../domain/orders/orders_bloc.dart';
import '../../widgets/maktab_bottom_app_bar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  int lastPage = 1;
  late final OrderReservationCubit _orderReservationCubit;
  bool listEndTriggered = false;

  @override
  void initState() {
    // context.read<OrdersBloc>().add(const GetOrdersEvent(1));
    // _orderReservationCubit = OrderReservationCubit();
    // _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<OrdersBloc>().add(const GetOrdersEvent(1));
    _orderReservationCubit = OrderReservationCubit();
    _scrollController.addListener(_scrollListener);
    super.didChangeDependencies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      log('Reached the end of the list');
      if (!listEndTriggered) {
        context.read<OrdersBloc>().add(GetMoreOrdersEvent(currentPage, lastPage));
        listEndTriggered = true;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _orderReservationCubit,
      child: Scaffold(
        appBar: const MaktabAppBar(
          title: 'الطلبات',
          leading: SizedBox(),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrdersSearchBox(currentPage: currentPage),
                SizedBox(height: 10.v),
                const OrdersStates(),
                SizedBox(height: 10.v),
                BlocConsumer<OrdersBloc, OrdersState>(
                  listener: (context, orderState) {
                    if (orderState is OrdersFailure) {
                      MaktabSnackbar.showError(context, orderState.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is OrdersLoading) {
                      return const LoadingWidget(0);
                    }
                    if (state is OrdersFailure) {
                      return const Center(
                        child: BodyText(
                          text: "Error",
                        ),
                      );
                    }
                    if (state is OrdersSuccess) {
                      lastPage = state.orders.firstOrNull?.lastPage ?? 1;
                      currentPage = state.currentPage;
                      listEndTriggered = false;
                      return OrdersList(
                        _scrollController,
                        orders: state.orders,
                        moreOrderLoader: false,
                      );
                    }
                    if (state is MoreOrdersLoading) {
                      return OrdersList(
                        _scrollController,
                        orders: state.prevOrders,
                        moreOrderLoader: true,
                      );
                    }
                    if (state is OrdersFilter) {
                      return OrdersList(
                        // _scrollController,
                        null,
                        orders: state.orders,
                        moreOrderLoader: false,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const MaktabBottomAppBar(),
      ),
    );
  }
}
