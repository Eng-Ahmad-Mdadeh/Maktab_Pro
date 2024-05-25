import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitBox extends StatelessWidget {
  const UnitBox({super.key, required this.unit, required this.office});

  final Office office;
  final Office unit;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OfficesCubit, OfficesState>(
      listener: (context, state) {
        if (state.officeApiCallState == OfficesApiCallState.update) {
          LoadingDialog.hide(context);
        } else if (state.officeApiCallState == OfficesApiCallState.loading) {
          LoadingDialog.show(context);
        } else if (state.officeApiCallState == OfficesApiCallState.success) {
          LoadingDialog.hide(context);
          context.pushNamed(AppRoutes.unitDetailsScreen, extra: office);
        } else if (state.officeApiCallState == OfficesApiCallState.failure) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, 'حدث خطأ ما');
        }
      },
      child: InkWell(
        onTap: () => context.read<OfficesCubit>().getOfficeById(unit.id),
        child: Row(
          children: [
            Container(
              width: 100.h,
              height: 100.v,
              decoration: BoxDecoration(
                color: AppColors.palePlatinum,
                borderRadius: BorderRadius.circular(15.v),
                border: Border.all(color: AppColors.slateGray),
              ),
              child: unit.mainImage.isNotEmpty
                  ? MaktabImageView(
                      imagePath: unit.mainImage,
                      fit: BoxFit.cover,
                      radius: BorderRadius.circular(15.v),
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(width: 15.h),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: unit.title),
                  SizedBox(height: 10.v),
                  Text(
                    unit.reject
                        ? 'مرفوض'
                        : Office.getOfficeState(unit.status, unit.active),
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: unit.reject
                              ? AppColors.cherryRed
                              : Office.getOfficeState(
                                          unit.status, unit.active) ==
                                      'معروض'
                                  ? AppColors.mintTeal
                                  : Office.getOfficeState(
                                              unit.status, unit.active) ==
                                          'معلق'
                                      ? AppColors.orangeAccent
                                      : AppColors.cherryRed,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.slateGray,
            ),
          ],
        ),
      ),
    );
  }
}
