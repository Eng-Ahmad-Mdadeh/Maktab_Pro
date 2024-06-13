import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/home/widgets/home_header.dart';
import 'package:maktab/presentation/home/widgets/latest_complaints_card.dart';
import 'package:maktab/presentation/home/widgets/latest_evaluation_section.dart.dart';
import 'package:maktab/presentation/home/widgets/latest_orders_card.dart';
import 'package:maktab/presentation/home/widgets/latest_transfers_section.dart';
import 'package:maktab/presentation/home/widgets/units_card.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

import '../../widgets/maktab_bottom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox(
          height: SizeHelper.height,
          child: Stack(
            fit: StackFit.loose,
            children: [
              const HomeHeader(),
              Positioned(
                top: 80.v,
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
      bottomNavigationBar: const MaktabBottomAppBar(),
    );
  }
}
