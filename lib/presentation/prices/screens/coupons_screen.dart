import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/presentation/prices/widgets/office_coupon_box.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/page_title.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'الكوبونات'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: PageTitle(
                      title: 'اختر مكتب',
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: MaktabButton(
                      height: 60.v,
                      text: 'إنشاء كود خصم',
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      icon: const Icon(Icons.add),
                      onPressed: () =>
                          context.pushNamed(AppRoutes.createCouponScreen),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.v),
              Expanded(
                child: BlocBuilder<OfficesCubit, OfficesState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<OfficesCubit>().getAllCoupons(),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return OfficeCouponBox(
                            office: context
                                .read<OfficesCubit>()
                                .state
                                .coupons[index],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.v),
                        itemCount:
                            context.read<OfficesCubit>().state.coupons.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
