import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/domain/contracts/contract/add/contract_cubit.dart';

import '../../../../../../../../../../domain/contracts/contract/add/contract_state.dart';
import '../contract_input_widget.dart';
import '../contract_select_widget.dart';

class BaseInfoWidget extends StatelessWidget {
  const BaseInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractCubit, ContractEntity>(
      builder: (context, state) {
        return Column(
          children: [
            ContractSelectWidget<PropertyOwnerType>(
              title: "هل أنت المالك أو الوكيل ؟",
              value: state.propertyOwner,
              onChanged: context.read<ContractCubit>().setpropertyOwner,
              // items: const ["المالك", "الوكيل"],
              children: [
                context.read<ContractCubit>().getName(PropertyOwnerType.owner),
                context.read<ContractCubit>().getName(PropertyOwnerType.agent)
              ],
              items: const [PropertyOwnerType.owner, PropertyOwnerType.agent],
            ),
            ContractSelectWidget<ContractApplicantType>(
              title: "هل أنت المؤجر أو المستأجر؟",
              value: state.contractApplicant,
              onChanged: context.read<ContractCubit>().setcontractApplicant,
              // items: const ["المستأجر", "المؤجر"],
              children: [
                context.read<ContractCubit>().getName(ContractApplicantType.tenant),
                context.read<ContractCubit>().getName(ContractApplicantType.lessor)
              ],
              items: const [ContractApplicantType.tenant, ContractApplicantType.lessor],
            ),
            ContractSelectWidget<LessorRoyalDeedType>(
              title: "حدد نوع الصك (اختياري)",
              value: state.lessorRoyalDeedType,
              req: false,
              children: [
                context.read<ContractCubit>().getName(LessorRoyalDeedType.electronic),
                context.read<ContractCubit>().getName(LessorRoyalDeedType.paper),
                context.read<ContractCubit>().getName(LessorRoyalDeedType.bank),
                context.read<ContractCubit>().getName(LessorRoyalDeedType.nothing),
              ],
              onChanged: context.read<ContractCubit>().setlessorRoyalDeedType,
              // items: const [
              //   "إلكتروني",
              //   "ورقي",
              //   "بنكي",
              //   "لا شيء",
              // ],
              items: const [
                LessorRoyalDeedType.electronic,
                LessorRoyalDeedType.paper,
                LessorRoyalDeedType.bank,
                LessorRoyalDeedType.nothing
              ],
            ),
            ContractInputWidget(
              controller: context.read<ContractCubit>().lessorRoyalDeedNumber,
              title: "رقم الصك (اختياري)",
              numberMode: true,
              req: false,
              onChanged: context.read<ContractCubit>().setlessorRoyalDeedNumber,
            ),
          ],
        );
      },
    );
  }
}
