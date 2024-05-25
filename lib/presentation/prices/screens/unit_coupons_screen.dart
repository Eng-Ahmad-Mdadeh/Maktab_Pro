import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/prices/widgets/unit_coupon_details_box.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class UnitCouponsScreen extends StatelessWidget {
  const UnitCouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficesCubit, OfficesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MaktabAppBar(
              title: 'كوبونات الوحدة: ${state.selectedOffice!.title}'),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return UnitCouponDetailsBox(
                          unitId: state.selectedOffice!.id,
                          coupon: state.selectedOffice!.coupons[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.v),
                      itemCount: state.selectedOffice!.coupons.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
