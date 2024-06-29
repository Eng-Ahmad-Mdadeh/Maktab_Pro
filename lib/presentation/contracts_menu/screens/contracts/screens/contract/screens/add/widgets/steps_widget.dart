import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import '../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../domain/contracts/contracts_step_cubit.dart';
import '../../../../../../../../resources/app_colors.dart';
import 'contract_step_dot.dart';

class StepsWidget extends StatelessWidget {
  const StepsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.h),
      child: BlocBuilder<ContractStepCubit, int>(builder: (context, i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => context.read<ContractCubit>().animateToPage(0),
              child: ContractStepDot(
                1,
                currentStep: i,
                title: "معلومات الأطراف",
              ),
            ),
            Container(color: AppColors.softAsh, width: 40, height: 2),
            InkWell(
              onTap: () => context.read<ContractCubit>().animateToPage(1),
              child: ContractStepDot(
                2,
                currentStep: i,
                title: "العقارات و الوحدات",
              ),
            ),
            Container(color: AppColors.softAsh, width: 40, height: 2),
            InkWell(
              onTap: () => context.read<ContractCubit>().animateToPage(2),
              child: ContractStepDot(
                3,
                currentStep: i,
                title: "البيانات المالية",
              ),
            ),
            Container(color: AppColors.softAsh, width: 40, height: 2),
            InkWell(
              onTap: () => context.read<ContractCubit>().animateToPage(3),
              child: ContractStepDot(
                4,
                currentStep: i,
                title: "محتوى العقد",
              ),
            ),
          ],
        );
      }),
    );
  }
}
