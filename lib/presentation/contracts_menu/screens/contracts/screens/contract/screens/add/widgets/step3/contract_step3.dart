import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/contracts/contract/add/contract_state.dart';

import '../../../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../contract_input_widget.dart';

class ContractStep3 extends StatelessWidget {
  const ContractStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 14.0.h, vertical: 25.0.v),
      child: Form(
        key: context.read<ContractCubit>().step3Key,
        child: BlocBuilder<ContractCubit, ContractEntity>(
          builder: (context, state) {
            return Column(
              children: [
                ContractInputWidget(
                  title: "قيمة العربون المدفوع إن وجد",
                  hint: "0 %",
                  numberMode: true,
                  disabled: state.isOrderOn ?? false,
                  onChanged: context.read<ContractCubit>().setdownPayment,
                  controller: context.read<ContractCubit>().downPayment,
                ),
                ContractInputWidget(
                  title: "قيمة التأمين المسترد إن وجد",
                  hint: "0 ريال",
                  numberMode: true,
                  onChanged: context.read<ContractCubit>().setinsuranceAmount,
                  controller: context.read<ContractCubit>().insuranceAmount,
                ),
                ContractInputWidget(
                  title: "مبلغ الإيجار الإجمالي",
                  hint: "0 ريال",
                  disabled: state.isOrderOn ?? false,
                  numberMode: true,
                  onChanged: context.read<ContractCubit>().settotalPrice,
                  controller: context.read<ContractCubit>().totalPrice,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
