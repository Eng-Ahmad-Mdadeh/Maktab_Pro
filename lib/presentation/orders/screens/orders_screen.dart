import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/navigation/navigation_cubit.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/presentation/orders/widgets/orders_search_box.dart';
import 'package:maktab/presentation/orders/widgets/orders_list.dart';
import 'package:maktab/presentation/orders/widgets/orders_states.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_bottom_app_bar.dart';
import 'package:maktab/presentation/widgets/shimmer_effect.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  ScrollController scrollController = ScrollController();
  int page = 0;

  @override
  void initState() {
    //   context.read<ProductsBloc>().add(GetProductsEvent(page: 0));
    // scrollController.addListener(() {
    //   if (scrollController.offset ==
    //           scrollController.position.maxScrollExtent &&
    //       context.read<ProductsBloc>().state.fetchingPrroductsState !=
    //           FetchingDataStates.loadingPaginate) {
    //     page = page + 10;
    //     context.read<ProductsBloc>().add(GetProductsEvent(page: page));
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationCubit, NavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: const MaktabAppBar(title: 'الطلبات'),
          body: WillPopScope(
            onWillPop: () async {
              if (state.currentIndexs.length > 1) {
                log(state.currentIndexs.toString());
                state.currentIndexs.removeLast();
                log(state.currentIndexs.toString());
                context
                    .read<NavigationCubit>()
                    .getNavBarItem(state.currentIndexs.last);
              } else if (state.currentIndexs.length == 1) {
                state.currentIndexs.clear();
                context.read<NavigationCubit>().getNavBarItem(0);
              }
              return true;
            },
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                child: BlocBuilder<ShimmerBloc, ShimmerState>(
                  builder: (context, state) {
                    return ShimmerEffect(
                      isLoading: state is ShowShimmerEffectState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrdersSearchBox(),
                          SizedBox(height: 10.v),
                          const OrdersStates(),
                          SizedBox(height: 10.v),
                          OrdersList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          bottomNavigationBar: const MaktabBottomAppBar(),
        );
      },
    );
  }
}
