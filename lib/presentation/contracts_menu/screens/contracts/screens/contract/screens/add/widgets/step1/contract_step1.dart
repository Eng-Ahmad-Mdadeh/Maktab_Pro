import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/contracts/contract/add/contract_cubit.dart';

import '../../../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../../../../data/models/contract/contract_model.dart';
import 'base_info_widget.dart';
import 'lessor_info_widget.dart';
import 'tenant_info_widget.dart';

class ContractStep1 extends StatelessWidget {
  const ContractStep1({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 37.0.v, right: 20.0.h, left: 20.0.h),
      padding: EdgeInsets.only(bottom: 25.0.v),
      child: SingleChildScrollView(
        child: Form(
          key: context.read<ContractCubit>().step1Key,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseInfoWidget(),
              LessorInfoWidget(),
              TenantInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
