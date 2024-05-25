// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/home/widgets/unit_info_item.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_loading.dart';
import 'package:maktab/presentation/widgets/retry_button.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitsCard extends StatelessWidget {
  UnitsCard({super.key});

  Office? selectedUnit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: SizeHelper.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'اعرض مكتبك'),
            SizedBox(height: 10.v),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250.v),
              child: BlocConsumer<OfficesCubit, OfficesState>(
                listener: (context, state) {
                  if (state.unitApiCallState == OfficesApiCallState.loading) {
                    LoadingDialog.show(context);
                  } else if (state.unitApiCallState ==
                      OfficesApiCallState.success) {
                    LoadingDialog.hide(context);
                    context.pushNamed(
                      AppRoutes.createUnitScreen,
                      extra: {
                        'office': state.selectedOffice,
                        'unit': selectedUnit,
                      },
                    );
                  } else if (state.unitApiCallState ==
                      OfficesApiCallState.failure) {
                    LoadingDialog.hide(context);
                  }
                },
                builder: (context, state) {
                  if (state.incompleteUnitsApiCallState ==
                      OfficesApiCallState.loading) {
                    return Center(child: loadingItem());
                  } else if (state.incompleteUnitsApiCallState ==
                      OfficesApiCallState.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BodyText(
                            text:
                                'لديك ${state.incompleteUnits.length} وحدة قيد النشر'),
                        SizedBox(height: 10.v),
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return UnitInfoItem(
                                unit: state.incompleteUnits[index],
                                onPressed: () async {
                                  await context
                                      .read<OfficesCubit>()
                                      .getUnitById(
                                          state.incompleteUnits[index].unitId!);
                                  selectedUnit = state.incompleteUnits[index];
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 12.v),
                            itemCount: state.incompleteUnits.length < 5
                                ? state.incompleteUnits.length
                                : state.incompleteUnits.sublist(0, 5).length,
                          ),
                        ),
                      ],
                    );
                  } else if (state.incompleteUnitsApiCallState ==
                      OfficesApiCallState.failure) {
                    return Center(
                      child: RetryButton(
                          onTap: () => context
                              .read<OfficesCubit>()
                              .getIncompleteUnits()),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
