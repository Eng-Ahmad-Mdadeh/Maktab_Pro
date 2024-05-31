// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/offices/widgets/office_info_box.dart';
import 'package:maktab/presentation/offices/widgets/office_info_item.dart';
import 'package:maktab/presentation/offices/widgets/unit_box.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/delete_alert_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_page_slider.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class OfficeBox extends StatelessWidget {
  OfficeBox({super.key, required this.office});

  final Office office;
  bool? isNameEditEnabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.softAsh),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: Row(
          children: [
            Expanded(
              child: SectionTitle(
                title: office.title??'',
                textAlign: TextAlign.right,
              ),
            ),
            if (office.isMarketing)
              Tooltip(
                message: 'يتم النشر من قبل مكتب',
                triggerMode: TooltipTriggerMode.tap,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.white),
                decoration: BoxDecoration(
                  color: AppColors.smokeGray,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'تسويق',
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.emeraldGreen),
                ),
              ),
            SizedBox(width: 12.h),
            Tooltip(
              message: office.isMarketing ? 'قيد المعالجة من قبل مكتب' : '',
              triggerMode: TooltipTriggerMode.tap,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.white),
              decoration: BoxDecoration(
                color: AppColors.smokeGray,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                office.units.where((unit) => unit.active).isNotEmpty
                    ? 'معروض'
                    : office.isMarketing
                        ? 'معلق'
                        : 'غير معروض',
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color:
                          office.units.where((unit) => unit.active).isNotEmpty
                              ? AppColors.emeraldGreen
                              : office.isMarketing
                                  ? AppColors.orangeAccent
                                  : AppColors.cherryRed,
                    ),
              ),
            ),
            SizedBox(width: 10.h),
            InkWell(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) {
                    return BlocProvider.value(
                      value: context.read<OfficeBloc>(),
                      child: BlocConsumer<OfficeBloc, OfficeState>(
                        listener: (ctx, officeState) {
                          if (officeState.officeApiCallState ==
                              OfficeApiCallState.success) {
                            ctx.pop();
                            ctx.read<OfficesCubit>().getMyOffices();
                          }
                        },
                        builder: (context, unitState) => DeleteAlertDialog(
                          alertText: 'لايمكنك التراجع بعد التأكيد',
                          isLoading: unitState.officeApiCallState ==
                              OfficeApiCallState.loading,
                          confirmOnPressed: () {
                            context
                                .read<OfficeBloc>()
                                .add(DeleteOfficeEvent(office.id));
                          },
                          cancelOnPressed: () => context.pop(),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.delete,
                color: AppColors.cherryRed,
              ),
            ),
          ],
        ),
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        OfficeInfoBox(
                          title: 'الاسم',
                          enableEdit: !office.isMarketing,
                          editOnTap: () {
                            context.pushNamed(AppRoutes.updateOfficeInfoScreen,
                                extra: office);
                          },
                          infoWidget: Column(
                            children: [
                              OfficeInfoItem(
                                  title: 'الاسم', value: office.title),
                              OfficeInfoItem(
                                  title: 'نوع المكتب',
                                  value: office.categoryAqar!.arName),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.v),
                        OfficeInfoBox(
                          title: 'الموقع',
                          enableEdit: !office.isMarketing,
                          editOnTap: () {
                            context.pushNamed(
                                AppRoutes.updateOfficeLoctionScreen,
                                extra: office);
                          },
                          infoWidget: Column(
                            children: [
                              OfficeInfoItem(
                                  title: 'المدينة',
                                  value: office.location!.city),
                              OfficeInfoItem(
                                  title: 'الحي',
                                  value: office.location!.neighborhood),
                              OfficeInfoItem(
                                  title: 'الشارع',
                                  value: office.location!.street),
                              OfficeInfoItem(
                                  title: 'الاتجاه',
                                  value: context
                                      .read<OfficesCubit>()
                                      .state
                                      .searchData!
                                      .officeInterfaces
                                      .firstWhereOrNull((interface) =>
                                          interface.id == office.interfaceId)!
                                      .arName),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.v),
                        if (office.isMarketing)
                          OfficeInfoBox(
                            title: 'بيانات تسجيل العقار',
                            enableEdit: !office.isMarketing,
                            infoWidget: const Column(
                              children: [
                                OfficeInfoItem(
                                  title: 'ترخيص العقار',
                                  valueWidget: InkWell(
                                    child: BodyText(
                                      text: 'تحميل',
                                      textAlign: TextAlign.left,
                                      textColor: AppColors.mintTeal,
                                    ),
                                  ),
                                ),
                                OfficeInfoItem(
                                  title: 'ترخيص المبنى',
                                  valueWidget: InkWell(
                                    child: BodyText(
                                      text: 'تحميل',
                                      textAlign: TextAlign.left,
                                      textColor: AppColors.mintTeal,
                                    ),
                                  ),
                                ),
                                OfficeInfoItem(
                                  title: 'الدفاع المدني',
                                  valueWidget: InkWell(
                                    child: BodyText(
                                      text: 'تحميل',
                                      textAlign: TextAlign.left,
                                      textColor: AppColors.mintTeal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.softAsh),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SectionTitle(title: 'وحدات هذا المكتب: '),
                        BodyText(
                          text: office.units.length.toString(),
                          textColor: AppColors.lightBlack,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.v),
                    MaktabPageSlider(
                      widgets: office.units
                          .map((unit) => UnitBox(unit: unit, office: office))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
