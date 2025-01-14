
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/presentation/home/widgets/unit_info_item.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_loading.dart';
import 'package:maktab_lessor/presentation/widgets/retry_button.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class UnitsCard extends StatelessWidget {
  UnitsCard({super.key});

  Office? selectedOffice;

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
            SizedBox(
              height: 10.0.v,
            ),
            const SectionTitle(
              title: 'استكمل اضافة اعلانك',
              fontSize: 15,
            ),
            SizedBox(height: 10.v),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250.v),
              child: BlocConsumer<OfficesCubit, OfficesState>(
                listener: (context, state) {
                  if (state.officeApiCallState == OfficesApiCallState.loading) {
                    LoadingDialog.show(context);
                  } else if (state.officeApiCallState == OfficesApiCallState.success) {
                    LoadingDialog.hide(context);
                    context.pushNamed(
                      AppRoutes.createOfficeScreen,
                      extra: state.selectedOffice,
                    );
                  } else if (state.officeApiCallState == OfficesApiCallState.failure) {
                    LoadingDialog.hide(context);
                  }
                },
                builder: (context, state) {
                  if (state.incompleteOfficesApiCallState == OfficesApiCallState.loading) {
                    return Center(child: loadingItem());
                  } else if (state.incompleteOfficesApiCallState == OfficesApiCallState.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BodyText(
                          text: 'لديك ${state.incompleteOffices.length} اعلان قيد النشر',
                          textColor: AppColors.deepOrange,
                        ),
                        SizedBox(height: 10.v),
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            itemBuilder: (context, index) {
                              return UnitInfoItem(
                                unit: state.incompleteOffices[index],
                                onPressed: () async {
                                  await context
                                      .read<OfficesCubit>()
                                      .getOfficeById(state.incompleteOffices[index].id);
                                  selectedOffice = state.incompleteOffices[index];
                                },
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 12.v),
                            itemCount: state.incompleteOffices.length < 5
                                ? state.incompleteOffices.length
                                : state.incompleteOffices.sublist(0, 5).length,
                          ),
                        ),
                      ],
                    );
                  } else if (state.incompleteOfficesApiCallState == OfficesApiCallState.failure) {
                    return Center(
                      child: RetryButton(onTap: () => context.read<OfficesCubit>().getIncompleteOffices()),
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
