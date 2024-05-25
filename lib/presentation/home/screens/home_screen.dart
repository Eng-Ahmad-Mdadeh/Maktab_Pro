// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/navigation/navigation_cubit.dart';
import 'package:maktab/presentation/home/widgets/home_header.dart';
import 'package:maktab/presentation/home/widgets/latest_complaints_card.dart';
import 'package:maktab/presentation/home/widgets/latest_evaluation_section.dart.dart';
import 'package:maktab/presentation/home/widgets/latest_orders_card.dart';
import 'package:maktab/presentation/home/widgets/latest_transfers_section.dart';
import 'package:maktab/presentation/home/widgets/units_card.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_bottom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationCubit, NavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightGray,
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
              child: SizedBox(
                height: SizeHelper.height,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    const HomeHeader(),
                    Positioned(
                      top: 100.v,
                      left: 20.h,
                      right: 20.h,
                      bottom: 0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            UnitsCard(),
                            SizedBox(height: 20.v),
                            LatestTransfersSection(),
                            SizedBox(height: 20.v),
                            LatestEvaluationsSection(),
                            SizedBox(height: 20.v),
                            LatestOrdersCard(),
                            SizedBox(height: 20.v),
                            LatestComplaintsCard(),
                          ],
                        ),
                      ),
                    ),
                  ],
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
