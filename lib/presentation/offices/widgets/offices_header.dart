import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/offices/offices_cubit.dart';
import 'package:maktab_lessor/presentation/offices/widgets/office_navigation_dropdown_button.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';

class OfficesHeader extends StatelessWidget {
  final Function(int) onIncompleteOfficeDelete;
  final Function(int) onIncompleteUnitDelete;
  final Function(int) onMyOfficeDelete;
  final GlobalKey _dropDownKey;

  const OfficesHeader(this._dropDownKey, {
    super.key,
    required this.onIncompleteOfficeDelete,
    required this.onIncompleteUnitDelete,
    required this.onMyOfficeDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: BlocListener<OfficesCubit, OfficesState>(
            listener: (context, state) {
              if (state.marketingRequestsApiCallState == OfficesApiCallState.loading) {
                LoadingDialog.show(context);
              }
              if (state.marketingRequestsApiCallState == OfficesApiCallState.update) {
                LoadingDialog.hide(context);
              } else if (state.marketingRequestsApiCallState == OfficesApiCallState.success) {
                LoadingDialog.hide(context);
                context.pushNamed(AppRoutes.marketingRequestsScreen);
              } else if (state.marketingRequestsApiCallState == OfficesApiCallState.failure) {
                LoadingDialog.hide(context);
                MaktabSnackbar.showError(context, 'حدث خطأ ما');
              }
            },
            child: MaktabButton(
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.lightCyan,
              text: 'طلبات التسويق',
              color: AppColors.white,
              height: 60.0.v,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              onPressed: () => context.read<OfficesCubit>().getMarketingRequests(),
            ),
          ),
        ),
        SizedBox(width: 5.h),
        Expanded(
          child: OfficeNavigationDropDownButton(
            _dropDownKey,
            onIncompleteOfficeDelete: onIncompleteOfficeDelete,
            onIncompleteUnitDelete: onIncompleteUnitDelete,
            onMyOfficeDelete: onMyOfficeDelete,
          ),
        ),
      ],
    );
  }
}
