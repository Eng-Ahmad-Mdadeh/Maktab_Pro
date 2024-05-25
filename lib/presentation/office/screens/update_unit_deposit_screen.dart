import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/unit_deposit_form_field.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/maktab_snack_bar.dart';

class UpdateUnitDepositScreen extends StatelessWidget {
  const UpdateUnitDepositScreen({super.key, required this.unit});

  final Office unit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<UnitBloc>()
        ..add(InitialUnitEvent(
            unit, null, context.read<OfficesCubit>().state.searchData)),
      child: BlocConsumer<UnitBloc, UnitState>(
        listener: (context, state) {
          if (state.unitApiCallState == UnitApiCallState.noCall) {
            context.pop();
          } else if (state.unitApiCallState == UnitApiCallState.success) {
            context.read<OfficesCubit>().getAllPrices(isUpdate: true);
            context.pop();
            MaktabSnackbar.showSuccess(context, 'تم تعديل عربون الوحدة بنجاح');
          } else if (state.unitApiCallState == UnitApiCallState.failure) {
            MaktabSnackbar.showError(context, 'فشل تعديل العربون');
          }
        },
        builder: (context, state) => state.isInitialized
            ? Scaffold(
                appBar: const MaktabAppBar(title: 'تعديل عربون الوحدة'),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UnitDepositFormField(),
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
                                  .add(UpdateUnitDepositEvent());
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
