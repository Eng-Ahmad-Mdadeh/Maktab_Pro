import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import 'additional_info_widget.dart';
import 'order_info_widget.dart';

class ContractStep2 extends StatelessWidget {

  const ContractStep2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 37.0.v, right: 20.0.h, left: 20.0.h, bottom: 37.0.v),
        child: Form(
          key: context.read<ContractCubit>().step2Key,
          child: const Column(
            children: [
              OrderInfoWidget(),
              AdditionalInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}








