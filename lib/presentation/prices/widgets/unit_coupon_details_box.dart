import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/coupon/coupon_model.dart';
import 'package:maktab/domain/coupon/coupon_bloc.dart';
import 'package:maktab/presentation/prices/widgets/unit_offer_info_item.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../data/models/office/office_model.dart';
import '../../../domain/offices/offices_cubit.dart';
import '../../widgets/confirm_alert_dialog.dart';

class UnitCouponDetailsBox extends StatelessWidget {
  const UnitCouponDetailsBox(
      {super.key, required this.coupon, required this.unit});

  final Coupon coupon;
  final  Office unit;

  @override
  Widget build(BuildContext context) {
    log('${coupon.priceTypeIds}.......');
    return Container(
      width: SizeHelper.width,
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.softAsh),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SectionTitle(title: coupon.name),
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pushNamed(
                        AppRoutes.createCouponScreen,
                        extra: {'coupon': coupon, 'unit': unit}),
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.emeraldTeal,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context2) {
                          return BlocProvider(
                            create: (context) => locator.get<CouponBloc>(),
                            child: BlocConsumer<CouponBloc, CouponState>(
                              listener: (context2, state) {
                                if (state.couponApiCallState ==
                                    OfferApiCallState.update) {
                                  context2
                                      .read<OfficesCubit>()
                                      .getOfficeById(unit.id, isUpdate: true);
                                  context2.pop();
                                }
                              },
                              builder: (context, state) {
                                return ConfirmAlertDialog(
                                  alertText: 'لايمكنك التراجع بعد التأكيد',
                                  isLoading: state.couponApiCallState ==
                                      OfferApiCallState.loading,
                                  confirmOnPressed: () {
                                    context
                                        .read<CouponBloc>()
                                        .add(DeleteCouponEvent(coupon.id));
                                  },
                                  cancelOnPressed: () => context.pop(),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.cherryRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.v),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                UnitOfferInfoItem(
                  title: 'قيمة الخصم',
                  value: coupon.discountType == 'percent'
                      ? '${coupon.discount.round().toString()}%'
                      : '${coupon.discount.round().toString()} ريال',
                ),
                UnitOfferInfoItem(
                  title: 'تاريخ البدء',
                  value: DateFormatterHelper.getFormated(coupon.startDate),
                ),
                UnitOfferInfoItem(
                  title: 'تاريخ الإنتهاء',
                  value: DateFormatterHelper.getFormated(coupon.endDate),
                ),
                UnitOfferInfoItem(
                  title: 'الحالة',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaktabSwitch(
                        value: coupon.status,
                        // activeColor: AppColors.emeraldTeal,
                        // activeTrackColor: AppColors.mintGreen,
                        onChanged: (value) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context2) {
                              return BlocProvider(
                                create: (context) => locator.get<CouponBloc>(),
                                child: BlocConsumer<CouponBloc, CouponState>(
                                  listener: (context2, state) {
                                    if (state.couponApiCallState ==
                                        OfferApiCallState.update) {
                                      context2
                                          .read<OfficesCubit>()
                                          .getOfficeById(unit.id,
                                              isUpdate: true);
                                      context2.pop();
                                    }
                                  },
                                  builder: (context, state) {
                                    return ConfirmAlertDialog(
                                      alertText: 'لايمكنك التراجع بعد التأكيد',
                                      isLoading: state.couponApiCallState ==
                                          OfferApiCallState.loading,
                                      confirmOnPressed: () {
                                        context.read<CouponBloc>().add(
                                            UpdateCouponStatusEvent(coupon.id));
                                      },
                                      cancelOnPressed: () => context.pop(),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(width: 10.h),
                      BodyText(
                        text: coupon.status ? 'فعال' : 'معلق',
                        textColor: coupon.status
                            ? AppColors.emeraldTeal
                            : AppColors.cherryRed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
