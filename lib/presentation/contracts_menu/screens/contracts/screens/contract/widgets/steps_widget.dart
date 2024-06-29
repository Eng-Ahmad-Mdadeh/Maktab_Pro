import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';

import '../../../../../../../domain/contracts/contracts_step_cubit.dart';
import '../../../../../../resources/app_colors.dart';
import 'contract_step_dot.dart';

class StepsWidget extends StatelessWidget {
  final Function(int) onPressed;

  const StepsWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.h),
      child: BlocBuilder<ContractStepCubit, int>(
        builder: (context, i) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => onPressed(0),
                child: ContractStepDot(
                  1,
                  currentStep: i,
                  title:  "معلومات العقد",
                ),
              ),
              Container(color: AppColors.softAsh, width: 30.h, height: 2.0.v),
              InkWell(
                onTap: () => onPressed(1),
                child: ContractStepDot(
                  2,
                  currentStep: i,
                  title: "العقارات و الوحدات",
                ),
              ),
              Container(color: AppColors.softAsh, width: 30.h, height: 2.0.v),
              InkWell(
                onTap: ()=> onPressed(2),
                child: ContractStepDot(
                  3,
                  currentStep: i,
                  title: "اطراف العقد",
                ),
              ),
              Container(color: AppColors.softAsh, width: 30.h, height: 2.0.v),
              InkWell(
                onTap: ()=> onPressed(3),
                child: ContractStepDot(
                  4,
                  currentStep: i,
                  title:  "البيانات المالية",
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
