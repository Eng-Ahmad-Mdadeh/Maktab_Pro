// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_navigation_item.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';

class PricesScreen extends StatelessWidget {
  PricesScreen({super.key});

  String screen = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'الأسعار'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: BlocListener<OfficesCubit, OfficesState>(
            listener: (context, state) {
              // log(state.pricesApiCallState.toString());
              if (state.pricesApiCallState == OfficesApiCallState.loading) {
                LoadingDialog.show(context);
              } else if (state.pricesApiCallState ==
                  OfficesApiCallState.update) {
                LoadingDialog.hide(context);
              } else if (state.pricesApiCallState ==
                  OfficesApiCallState.success) {
                LoadingDialog.hide(context);
                if (screen == 'prices') {
                  context.pushNamed(AppRoutes.basicPricesScreen);
                } else if (screen == 'offers') {
                  context.pushNamed(AppRoutes.offerPricesScreen);
                } else if (screen == 'deposit') {
                  context.pushNamed(AppRoutes.depositScreen);
                } else if (screen == 'coupons') {
                  context.pushNamed(AppRoutes.couponsScreen);
                }
              } else if (state.pricesApiCallState ==
                  OfficesApiCallState.failure) {
                LoadingDialog.hide(context);
                MaktabSnackbar.showError(context, 'حدث خطأ ما');
              }
            },
            child: Column(
              children: [
                MaktabNavigationItemItem(
                  title: 'الأسعار الأساسية',
                  onTap: () {
                    screen = 'prices';
                    context.read<OfficesCubit>().getAllPrices();
                  },
                ),
                MaktabNavigationItemItem(
                  title: 'أسعار العروض',
                  onTap: () {
                    screen = 'offers';
                    context.read<OfficesCubit>().getAllOffers();
                  },
                ),
                MaktabNavigationItemItem(
                  title: 'العربون',
                  onTap: () {
                    screen = 'deposit';
                    context.read<OfficesCubit>().getAllPrices();
                  },
                ),
                MaktabNavigationItemItem(
                  title: 'الكوبونات',
                  onTap: () {
                    screen = 'coupons';
                    context.read<OfficesCubit>().getAllCoupons();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
