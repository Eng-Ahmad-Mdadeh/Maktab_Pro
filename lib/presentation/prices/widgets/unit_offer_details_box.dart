import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/date_formatter_helper.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/models/offer/offer_model.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/offer/offer_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/prices/widgets/unit_offer_info_item.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/confirm_alert_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_switch.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitOfferDetailsBox extends StatelessWidget {
  const UnitOfferDetailsBox(
      {super.key, required this.offer, required this.unit});

  final Offer offer;
  final Office unit;

  @override
  Widget build(BuildContext context) {
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
              SectionTitle(title: offer.name),
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pushNamed(
                        AppRoutes.createOfferScreen,
                        extra: {'offer': offer, 'unit': unit}),
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
                            create: (context) => locator.get<OfferBloc>(),
                            child: BlocConsumer<OfferBloc, OfferState>(
                              listener: (context2, state) {
                                if (state.offerApiCallState ==
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
                                  isLoading: state.offerApiCallState ==
                                      OfferApiCallState.loading,
                                  confirmOnPressed: () {
                                    context
                                        .read<OfferBloc>()
                                        .add(DeleteOfferEvent(offer.id));
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
                  title: 'قيمة العرض',
                  value: offer.discountType == 'percent'
                      ? '${offer.discount.round().toString()}%'
                      : '${offer.discount.round().toString()} ريال',
                ),
                UnitOfferInfoItem(
                  title: 'تاريخ البدء',
                  value: DateFormatterHelper.getFormated(offer.startDate),
                ),
                UnitOfferInfoItem(
                  title: 'تاريخ الإنتهاء',
                  value: DateFormatterHelper.getFormated(offer.endDate),
                ),
                UnitOfferInfoItem(
                  title: 'الحالة',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaktabSwitch(
                        value: offer.status,
                        // activeColor: AppColors.emeraldTeal,
                        // activeTrackColor: AppColors.mintGreen,
                        onChanged: (value) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context2) {
                              return BlocProvider(
                                create: (context) => locator.get<OfferBloc>(),
                                child: BlocConsumer<OfferBloc, OfferState>(
                                  listener: (context2, state) {
                                    if (state.offerApiCallState ==
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
                                      isLoading: state.offerApiCallState ==
                                          OfferApiCallState.loading,
                                      confirmOnPressed: () {
                                        context.read<OfferBloc>().add(
                                            UpdateOfferStatusEvent(offer.id));
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
                        text: offer.status ? 'فعال' : 'معلق',
                        textColor: offer.status
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
