import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../domain/contracts/contract/add/contract_state.dart';
import '../../../../../../../../../domain/contracts/contract/contract_bloc.dart';
import '../../../../../../../../../domain/contracts/contracts_step_cubit.dart';
import '../../../../../../../../resources/app_colors.dart';
import '../../../../../../../../widgets/maktab_button.dart';

class ContractsButtons extends StatelessWidget {
  const ContractsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractStepCubit, int>(
      builder: (context, state) {
        return Column(
          children: [
            LinearProgressIndicator(
              minHeight: 10.v,
              borderRadius: BorderRadius.circular(20),
              backgroundColor: AppColors.mintGreen,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.emeraldTeal,
              ),
              value: state.toDouble() / 4,
            ),
            Container(
              height: 100.v,
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
              child: Row(
                children: [
                  Expanded(
                    child: MaktabButton(
                      text: 'السابق',
                      backgroundColor: AppColors.white,
                      color: AppColors.emeraldTeal,
                      isBordered: true,
                      onPressed: context.read<ContractCubit>().previousPage,
                    ),
                  ),
                  SizedBox(width: 20.h),
                  Expanded(
                    child: BlocBuilder<ContractBloc, ContractState>(
                      builder: (context, contractState) {
                        return MaktabButton(
                          text: state == 4 ? "إنشاء وحفظ" : "التالي",
                          isLoading: contractState is ContractLoading,
                          // backgroundColor: !state.isStepCompleted || state.officeApiCallState == OfficeApiCallState.loading
                          //     ? AppColors.mintTeal.withOpacity(0.2)
                          //     : AppColors.mintTeal,
                          // isEnabled: state.isStepCompleted,
                          // isLoading: state.officeApiCallState == OfficeApiCallState.loading,
                          onPressed: () {
                            context.read<ContractCubit>().nextPage(state - 1, context).then((e) {
                              if (e) {
                                final ContractEntity entity = context.read<ContractCubit>().state;
                                context.read<ContractBloc>().add(CreateContractEvent(entity));
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 14.0.h),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       MaktabButton(
    //         width: 100.0.h,
    //         height: 50.0.v,
    //         bold: false,
    //         fontSize: 17.0,
    //         borderRadius: BorderRadius.zero,
    //         text: "السابق",
    //         backgroundColor: AppColors.gray,
    //         color: AppColors.black,
    //         onPressed: onPrevious,
    //       ),
    //       MaktabButton(
    //         width: isLastPage ? 140.0 : 100.0.h,
    //         height: 50.0.v,
    //         bold: false,
    //         fontSize: 17.0,
    //         borderRadius: BorderRadius.zero,
    //         text: isLastPage ? "إنشاء وحفظ" : "التالي",
    //         onPressed: onNext,
    //       ),
    //     ],
    //   ),
    // );
  }
}
