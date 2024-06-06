import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/contracts/contract/add/contract_cubit.dart';

import 'step1/contract_step1.dart';
import 'step2/contract_step2.dart';
import 'step3/contract_step3.dart';
import 'step4/contract_step4.dart';

class ContractPages extends StatelessWidget {
  const ContractPages({super.key});


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: context.read<ContractCubit>().pageController,
        children: const [
          ContractStep1(),
          ContractStep2(),
          ContractStep3(),
          ContractStep4(),
        ],
      ),
    );
  }
}
