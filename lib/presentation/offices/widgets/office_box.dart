import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_info_box.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_info_item.dart';
import 'package:maktab_lessor/presentation/offices/widgets/unit_box.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/delete_alert_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_page_slider.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_video_player.dart';

import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';

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
                title: office.title ?? '',
                textAlign: TextAlign.right,
                overflow: TextOverflow.visible,
                fontSize: 17.0,
              ),
            ),
            Column(
              children: [
                if (office.isMarketing)
                  Tooltip(
                    message: 'يتم النشر من قبل مكتب',
                    triggerMode: TooltipTriggerMode.tap,
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                    decoration: BoxDecoration(
                      color: AppColors.smokeGray,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const BodyText(
                      text: 'تسويق',
                      textColor: AppColors.mintGreen,
                    ),
                  ),
                SizedBox(height: 5.h),
                Tooltip(
                  message: office.isMarketing ? 'قيد المعالجة من قبل مكتب' : '',
                  triggerMode: TooltipTriggerMode.tap,
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                  decoration: BoxDecoration(
                    color: AppColors.smokeGray,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: BodyText(
                    text: office.units.where((unit) => unit.active).isNotEmpty
                        ? 'معروض'
                        : office.isMarketing
                            ? 'معلق'
                            : 'غير معروض',
                    textColor: office.units.where((unit) => unit.active).isNotEmpty
                        ? AppColors.emeraldGreen
                        : office.isMarketing
                            ? AppColors.orangeAccent
                            : AppColors.cherryRed,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.h),
            InkWell(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) {
                    return BlocProvider<OfficeBloc>(
                      create: (context) => locator<OfficeBloc>(),
                      child: BlocConsumer<OfficeBloc, OfficeState>(
                        listener: (ctx, officeState) {
                          if (officeState.officeApiCallState == OfficeApiCallState.success) {
                            ctx.pop();
                            ctx.read<OfficesCubit>().getMyOffices();
                          }
                        },
                        builder: (context, unitState) => DeleteAlertDialog(
                          alertText: 'لايمكنك التراجع بعد التأكيد',
                          isLoading: unitState.officeApiCallState == OfficeApiCallState.loading,
                          confirmOnPressed: () {
                            context.read<OfficeBloc>().add(DeleteOfficeEvent(office.id));
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
          BlocBuilder<OfficesCubit, OfficesState>(
            builder: (context, state) {
              return Column(
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
                              enableEdit: true,
                              editOnTap: () {
                                context.pushNamed(AppRoutes.updateOfficeInfoScreen, extra: office);
                              },
                              infoWidget: Column(
                                children: [
                                  OfficeInfoItem(title: 'الاسم', value: office.title),
                                  OfficeInfoItem(title: 'نوع المكتب', value: office.categoryAqar?.arName),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.v),
                            OfficeInfoBox(
                              title: 'الموقع',
                              enableEdit: office.isMarketing,
                              editOnTap: () {
                                context.pushNamed(AppRoutes.updateOfficeLoctionScreen, extra: office);
                              },
                              infoWidget: Column(
                                children: [
                                  OfficeInfoItem(title: 'المدينة', value: office.location!.city),
                                  OfficeInfoItem(title: 'الحي', value: office.location!.neighborhood),
                                  OfficeInfoItem(title: 'الشارع', value: office.location!.street),
                                  if (office.interfaceId != null)
                                    OfficeInfoItem(
                                        title: 'الاتجاه',
                                        value: context
                                            .read<OfficesCubit>()
                                            .state
                                            .searchData!
                                            .officeInterfaces
                                            .firstWhereOrNull((interface) => interface.id == office.interfaceId)!
                                            .arName),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.v),
                            OfficeInfoBox(
                              title: 'تصنيف المكتب',
                              enableEdit: office.isMarketing,
                              editOnTap: () => context.pushNamed(AppRoutes.updateUnitCategoryScreen, extra: {
                                'office': office,
                              }),
                              infoWidget: BodyText(
                                text: context
                                    .read<OfficesCubit>()
                                    .state
                                    .searchData!
                                    .officeCategories
                                    .firstWhere((category) => category.id == office.categoryId)
                                    .arName,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            OfficeInfoBox(
                              title: 'تفاصيل المكتب',
                              enableEdit: office.isMarketing,
                              editOnTap: () => context.pushNamed(AppRoutes.updateUnitDetailsScreen, extra: office),
                              infoWidget: Column(
                                children: [
                                  OfficeInfoItem(
                                    title: 'الدور',
                                    value: office.details
                                        .firstWhere((detail) => detail.arName == 'الدور')
                                        .numberDetails
                                        .toString(),
                                  ),
                                  OfficeInfoItem(
                                    title: 'عمر المكتب',
                                    value: office.propertyAge?.nameAr,
                                  ),
                                  // if (office.details
                                  //         .firstWhereOrNull((detail) => detail.arName == 'عدد المكاتب') !=
                                  //     null)
                                  OfficeInfoItem(
                                    title: 'عدد الغرف',
                                    value: office.details
                                        .firstWhereOrNull((detail) => detail.arName == 'عدد الغرف')!
                                        .numberDetails
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            OfficeInfoBox(
                              title: 'وصف وحدتك',
                              enableEdit: true,
                              editOnTap: () => context.pushNamed(AppRoutes.updateUnitDescriptionScreen, extra: office),
                              infoWidget: BodyText(text: office.description ?? ''),
                            ),
                            SizedBox(height: 20.h),
                            OfficeInfoBox(
                              title: 'المرافق',
                              enableEdit: true,
                              editOnTap: () => context.pushNamed(AppRoutes.updateUnitFacilitiesScreen, extra: office),
                              infoWidget: BodyText(
                                text: office.facilities.isNotEmpty
                                    ? office.facilities.map((facility) => facility.arName).toList().join(' , ')
                                    : 'غير محدد',
                              ),
                            ),
                            SizedBox(height: 20.h),
                            OfficeInfoBox(
                              title: 'المميزات',
                              enableEdit: true,
                              editOnTap: () => context.pushNamed(AppRoutes.updateUnitFeaturesScreen, extra: office),
                              infoWidget: BodyText(
                                text: office.features.isNotEmpty
                                    ? office.features.map((feature) => feature.arName).toList().join(' , ')
                                    : 'غير محدد',
                              ),
                            ),
                            SizedBox(height: 20.h),
                            OfficeInfoBox(
                              title: 'الخدمات الأساسية',
                              enableEdit: office.isMarketing,
                              editOnTap: () => context.pushNamed(AppRoutes.updateUnitServicesScreen, extra: office),
                              infoWidget: BodyText(
                                text: office.propertyUtilities.isNotEmpty
                                    ? office.propertyUtilities.map((service) => service.arName).toList().join(' , ')
                                    : 'غير محدد',
                              ),
                            ),
                            SizedBox(height: 20.h),
                            OfficeInfoBox(
                              title: 'وسائل الراحة',
                              enableEdit: true,
                              editOnTap: () => context.pushNamed(AppRoutes.updateUnitComfortsScreen, extra: office),
                              infoWidget: BodyText(
                                text: office.comforts.isNotEmpty
                                    ? office.comforts.map((comfort) => comfort.arName).toList().join(' , ')
                                    : 'غير محدد',
                              ),
                            ),
                            SizedBox(height: 20.h),
                            OfficeInfoBox(
                              title: 'جميع الملفات',
                              enableEdit: true,
                              editOnTap: () => context.pushNamed(AppRoutes.updateUnitFilesScreen, extra: office),
                              infoWidget: Column(
                                children: [
                                  if ((office.mainImage ?? '').isNotEmpty)
                                    MaktabImageView(
                                      width: SizeHelper.width,
                                      imagePath: office.mainImage!,
                                      radius: BorderRadius.circular(15.adaptSize),
                                    ),
                                  SizedBox(height: 15.h),
                                  if (office.files.isNotEmpty)
                                    GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.h,
                                      mainAxisSpacing: 10.v,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: office.files
                                          .where((file) => file.typeFile == 'image')
                                          .map(
                                            (image) => MaktabImageView(
                                              imagePath: image.path,
                                              radius: BorderRadius.circular(15.adaptSize),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  SizedBox(height: 15.h),
                                  if (office.files.firstWhereOrNull((file) => file.typeFile == 'video') != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.adaptSize),
                                      child: MaktabVideoPlayer(
                                        videoLink:
                                            office.files.firstWhereOrNull((file) => file.typeFile == 'video')!.path,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (office.isMarketing)
                              const OfficeInfoBox(
                                title: 'بيانات تسجيل العقار',
                                enableEdit: true,
                                infoWidget: Column(
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
                  // const Divider(color: AppColors.softAsh),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           const SectionTitle(title: 'وحدات هذا المكتب: '),
                  //           BodyText(
                  //             text: office.units.length.toString(),
                  //             textColor: AppColors.lightBlack,
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 15.v),
                  //       MaktabPageSlider(
                  //         widgets: office.units.map((unit) => UnitBox(unit: unit, office: office)).toList(),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
