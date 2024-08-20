import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_info_box.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_info_item.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/confirm_alert_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/delete_alert_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_image_view.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_video_player.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class UnitDetailsScreen extends StatefulWidget {
  const UnitDetailsScreen({super.key, required this.office});

  final Office office;

  @override
  State<UnitDetailsScreen> createState() => _UnitDetailsScreenState();
}

class _UnitDetailsScreenState extends State<UnitDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficesCubit, OfficesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: MaktabAppBar(title: 'الوحدة: ${state.selectedOffice!.title}'),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionTitle(title: state.selectedOffice!.title ?? ''),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (ctx) {
                              return BlocProvider.value(
                                value: context.read<UnitBloc>(),
                                child: BlocConsumer<UnitBloc, UnitState>(
                                  listener: (ctx, unitState) {
                                    if (unitState.unitApiCallState == UnitApiCallState.success) {
                                      ctx.pop();
                                      ctx.pop();
                                      ctx.read<OfficesCubit>().getMyOffices();
                                    }
                                  },
                                  builder: (context, unitState) => DeleteAlertDialog(
                                    alertText: 'لايمكنك التراجع بعد التأكيد',
                                    isLoading: unitState.unitApiCallState == UnitApiCallState.loading,
                                    confirmOnPressed: () {
                                      context.read<UnitBloc>().add(DeleteUnitEvent(state.selectedOffice!.id));
                                    },
                                    cancelOnPressed: () => context.pop(),
                                  ),
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
                  SizedBox(height: 10.v),
                  OfficeInfoBox(
                    title: 'معلومات الوحدة',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () =>
                        context.pushNamed(AppRoutes.updateUnitInfoScreen, extra: {'office': widget.office, 'unit': state.selectedOffice}),
                    infoWidget: Column(
                      children: [
                        OfficeInfoItem(
                          title: 'الاسم',
                          value: state.selectedOffice!.title,
                        ),
                        OfficeInfoItem(
                          title: 'رقم الوحدة',
                          value: state.selectedOffice!.refNumber,
                        ),
                        OfficeInfoItem(
                          title: 'المساحة',
                          value: state.selectedOffice?.space != null ? state.selectedOffice!.space.toString() : 'غير محدد',
                        ),
                        OfficeInfoItem(
                          title: 'التجهيز',
                          value:
                              (state.selectedOffice?.furnisher ?? '').isNotEmpty ? state.selectedOffice!.furnisher.toString() : 'غير محدد',
                        ),
                        OfficeInfoItem(
                          title: 'علاقة المعلن',
                          value: (state.selectedOffice?.advertiserRelationship ?? '').isNotEmpty
                              ? state.selectedOffice!.advertiserRelationship.toString()
                              : 'غير محدد',
                        ),
                        OfficeInfoItem(
                          title: 'نوع علاقة المعلن',
                          value: (state.selectedOffice!.advertiserRelationshipType ?? '').isNotEmpty
                              ? state.selectedOffice!.advertiserRelationshipType.toString()
                              : 'غير محدد',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'حالة عرض الوحدة',
                    editOnTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) {
                          return BlocProvider.value(
                            value: context.read<UnitBloc>(),
                            child: BlocConsumer<UnitBloc, UnitState>(
                              listener: (ctx, unitState) {
                                if (unitState.unitApiCallState == UnitApiCallState.success) {
                                  context.read<OfficesCubit>().getMyOffices().then((e) {
                                    ctx.read<OfficesCubit>().getOfficeById(state.selectedOffice!.id, isUpdate: true);
                                    ctx.pop();
                                  });
                                }
                              },
                              builder: (context, unitState) => ConfirmAlertDialog(
                                alertText: 'أنت على وشك عرض / اخفاء وحدتك',
                                isLoading: unitState.unitApiCallState == UnitApiCallState.loading,
                                confirmOnPressed: () {
                                  context.read<UnitBloc>().add(UpdateUnitStatusEvent(state.selectedOffice!.id));
                                },
                                cancelOnPressed: () => context.pop(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    infoWidget: Column(
                      children: [
                        OfficeInfoItem(
                          title: 'الحالة',
                          value: Office.getOfficeState(state.selectedOffice!.status, state.selectedOffice!.active),
                          valueColor: Office.getOfficeState(state.selectedOffice!.status, state.selectedOffice!.active) == 'معروض'
                              ? AppColors.mintTeal
                              : Office.getOfficeState(state.selectedOffice!.status, state.selectedOffice!.active) == 'معلق'
                                  ? AppColors.orangeAccent
                                  : AppColors.cherryRed,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'تصنيف المكتب',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () => context
                        .pushNamed(AppRoutes.updateUnitCategoryScreen, extra: {'office': widget.office, 'unit': state.selectedOffice}),
                    infoWidget: BodyText(
                      text: context
                          .read<OfficesCubit>()
                          .state
                          .searchData!
                          .officeCategories
                          .firstWhere((category) => category.id == state.selectedOffice!.categoryId)
                          .arName,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'تفاصيل المكتب',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () => context.pushNamed(AppRoutes.updateUnitDetailsScreen, extra: state.selectedOffice),
                    infoWidget: Column(
                      children: [
                        OfficeInfoItem(
                          title: 'الدور',
                          value: state.selectedOffice!.details.firstWhere((detail) => detail.arName == 'الدور').numberDetails.toString(),
                        ),
                        OfficeInfoItem(
                          title: 'عمر المكتب',
                          value:
                              state.selectedOffice!.details.firstWhere((detail) => detail.arName == 'عمر المكتب').numberDetails.toString(),
                        ),
                        if (state.selectedOffice!.details.firstWhereOrNull((detail) => detail.arName == 'عدد المكاتب') != null)
                          OfficeInfoItem(
                            title: 'عدد المكاتب',
                            value: state.selectedOffice!.details
                                .firstWhereOrNull((detail) => detail.arName == 'عدد المكاتب')!
                                .numberDetails
                                .toString(),
                          ),
                        if (state.selectedOffice!.details.firstWhereOrNull((detail) => detail.arName == 'غرف الاجتماعات') != null)
                          OfficeInfoItem(
                            title: 'غرف الاجتماعات',
                            value: state.selectedOffice!.details
                                .firstWhere((detail) => detail.arName == 'غرف الاجتماعات')
                                .numberDetails
                                .toString(),
                          ),
                        if (state.selectedOffice!.details.firstWhereOrNull((detail) => detail.arName == 'عدد الطاولات') != null)
                          OfficeInfoItem(
                            title: 'عدد الطاولات',
                            value: state.selectedOffice!.details
                                .firstWhereOrNull((detail) => detail.arName == 'عدد الطاولات')!
                                .numberDetails
                                .toString(),
                          ),
                        if (state.selectedOffice!.details.firstWhereOrNull((detail) => detail.arName == 'مساحات عمل مشتركة') != null)
                          OfficeInfoItem(
                            title: 'مساحات عمل مشتركة',
                            value: state.selectedOffice!.details
                                .firstWhereOrNull((detail) => detail.arName == 'مساحات عمل مشتركة')!
                                .numberDetails
                                .toString(),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'وصف وحدتك',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () => context.pushNamed(AppRoutes.updateUnitDescriptionScreen, extra: state.selectedOffice),
                    infoWidget: BodyText(text: state.selectedOffice!.description ?? ''),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'المرافق',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () => context.pushNamed(AppRoutes.updateUnitFacilitiesScreen, extra: state.selectedOffice),
                    infoWidget: BodyText(
                      text: state.selectedOffice!.facilities.isNotEmpty
                          ? state.selectedOffice!.facilities.map((facility) => facility.arName).toList().join(' , ')
                          : 'غير محدد',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'المميزات',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () => context.pushNamed(AppRoutes.updateUnitFeaturesScreen, extra: state.selectedOffice),
                    infoWidget: BodyText(
                      text: state.selectedOffice!.features.isNotEmpty
                          ? state.selectedOffice!.features.map((feature) => feature.arName).toList().join(' , ')
                          : 'غير محدد',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'الخدمات',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () => context.pushNamed(AppRoutes.updateUnitServicesScreen, extra: state.selectedOffice),
                    infoWidget: BodyText(
                      text: state.selectedOffice!.services.isNotEmpty
                          ? state.selectedOffice!.services.map((service) => service.arName).toList().join(' , ')
                          : 'غير محدد',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'وسائل الراحة',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () => context.pushNamed(AppRoutes.updateUnitComfortsScreen, extra: state.selectedOffice),
                    infoWidget: BodyText(
                      text: state.selectedOffice!.comforts.isNotEmpty
                          ? state.selectedOffice!.comforts.map((comfort) => comfort.arName).toList().join(' , ')
                          : 'غير محدد',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OfficeInfoBox(
                    title: 'جميع الملفات',
                    enableEdit: !widget.office.isMarketing,
                    editOnTap: () => context.pushNamed(AppRoutes.updateUnitFilesScreen, extra: state.selectedOffice),
                    infoWidget: Column(
                      children: [
                        if ((state.selectedOffice?.mainImage ?? '').isNotEmpty)
                          MaktabImageView(
                            width: SizeHelper.width,
                            imagePath: state.selectedOffice!.mainImage!,
                            radius: BorderRadius.circular(15.adaptSize),
                          ),
                        SizedBox(height: 15.h),
                        if (state.selectedOffice!.files.isNotEmpty)
                          GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.h,
                            mainAxisSpacing: 10.v,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: state.selectedOffice!.files
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
                        if (state.selectedOffice!.files.firstWhereOrNull((file) => file.typeFile == 'video') != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.adaptSize),
                            child: MaktabVideoPlayer(
                              videoLink: state.selectedOffice!.files.firstWhereOrNull((file) => file.typeFile == 'video')!.path,
                            ),
                          ),
                      ],
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
