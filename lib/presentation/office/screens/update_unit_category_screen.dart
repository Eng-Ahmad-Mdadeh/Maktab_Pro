import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/office/widgets/office_category_box.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

import '../../widgets/maktab_button.dart';

class UpdateUnitCategoryScreen extends StatelessWidget {
  const UpdateUnitCategoryScreen(
      {super.key, required this.office, required this.unit});

  final Office office;
  final Office unit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UnitBloc>()
        ..add(InitialUnitEvent(
            unit, office, context.read<OfficesCubit>().state.searchData)),
      child: BlocConsumer<UnitBloc, UnitState>(
        listener: (context, state) {
          if (state.unitApiCallState == UnitApiCallState.noCall) {
            context.pop();
          } else if (state.unitApiCallState == UnitApiCallState.success) {
            context.read<OfficesCubit>().getOfficeById(unit.id, isUpdate: true);
            context.read<OfficesCubit>().getMyOffices();
            context.pop();
            MaktabSnackbar.showSuccess(context, 'تم تعديل تصنيف الوحدة بنجاح');
          } else if (state.unitApiCallState == UnitApiCallState.failure) {
            MaktabSnackbar.showError(context, 'فشل تعديل التصنيف');
          }
        },
        builder: (context, state) => state.isInitialized
            ? Scaffold(
                appBar: const MaktabAppBar(title: 'تعديل تصنيف الوحدة'),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: 'تصنيف مكتبك'),
                        SizedBox(height: 10.v),
                        const BodyText(text: 'حدد التصميم المناسب'),
                        SizedBox(height: 15.v),
                        BlocBuilder<UnitBloc, UnitState>(
                          builder: (context, state) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 10.v,
                                crossAxisSpacing: 8.h,
                              ),
                              itemCount: context
                                  .read<OfficesCubit>()
                                  .state
                                  .searchData!
                                  .officeCategories
                                  .length,
                              itemBuilder: (context, index) {
                                return OfficeCategoryBox(
                                  officeCategory: context
                                      .read<OfficesCubit>()
                                      .state
                                      .searchData!
                                      .officeCategories[index],
                                  isSelected: context
                                          .read<UnitBloc>()
                                          .state
                                          .categoryId ==
                                      context
                                          .read<OfficesCubit>()
                                          .state
                                          .searchData!
                                          .officeCategories[index]
                                          .id,
                                  onTap: () {
                                    context.read<UnitBloc>().add(
                                        SelectCategoryEvent(context
                                            .read<OfficesCubit>()
                                            .state
                                            .searchData!
                                            .officeCategories[index]
                                            .id));
                                  },
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.v),
                        Container(
                          height: 100.v,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 20.v),
                          child: MaktabButton(
                            text: 'حفظ التغييرات',
                            isLoading: state.unitApiCallState ==
                                UnitApiCallState.loading,
                            backgroundColor: AppColors.mintTeal,
                            onPressed: () {
                              context
                                  .read<UnitBloc>()
                                  .add(UpdateUnitCategoryEvent());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
