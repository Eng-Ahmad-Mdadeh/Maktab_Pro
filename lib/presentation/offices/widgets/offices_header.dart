import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/presentation/offices/widgets/office_navigation_dropdown_button.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';

class OfficesHeader extends StatelessWidget {
  const OfficesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: BlocListener<OfficesCubit, OfficesState>(
            listener: (context, state) {
              if (state.marketingRequestsApiCallState ==
                  OfficesApiCallState.loading) {
                LoadingDialog.show(context);
              }
              if (state.marketingRequestsApiCallState ==
                  OfficesApiCallState.update) {
                LoadingDialog.hide(context);
              } else if (state.marketingRequestsApiCallState ==
                  OfficesApiCallState.success) {
                LoadingDialog.hide(context);
                context.pushNamed(AppRoutes.marketingRequestsScreen);
              } else if (state.marketingRequestsApiCallState ==
                  OfficesApiCallState.failure) {
                LoadingDialog.hide(context);
                MaktabSnackbar.showError(context, 'حدث خطأ ما');
              }
            },
            child: MaktabButton(
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.lightCyan,
              text: 'طلبات التسويق',
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
              onPressed: () =>
                  context.read<OfficesCubit>().getMarketingRequests(),
            ),
          ),
        ),
        SizedBox(width: 5.h),
        const Expanded(
          child: OfficeNavigationDropDownButton(),
        ),
      ],
    );
  }
}
