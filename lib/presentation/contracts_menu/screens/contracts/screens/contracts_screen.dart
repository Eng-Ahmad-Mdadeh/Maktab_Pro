import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/retry_button.dart';

import '../../../../../../core/helpers/size_helper.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../data/models/contract/contract_model.dart';
import '../../../../../domain/contracts/contract/contract_bloc.dart';
import '../../../../../domain/contracts/contracts_bloc.dart';
import '../../../../../domain/contracts/contracts_event.dart';
import '../../../../../domain/contracts/contracts_state.dart';
import '../../../../widgets/maktab_app_bar.dart';
import '../../../../widgets/shimmer_effect.dart';
import '../../../../widgets/body_text.dart';
import '../../../../widgets/section_title.dart';
import '../widgets/contract_type_menu_widget.dart';
import '../widgets/contracts_widget.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(
        title: "العقود",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
          child: BlocBuilder<ContractsBloc, ContractsState>(
            builder: (context, state) {
              if (state is LoadingContractsState) {
                return ShimmerEffect(
                  isLoading: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(title: "نوع العقد"),
                      SizedBox(height: 20.v),
                      ContractTypeMenuWidget(
                        value: ContractType.none,
                        contractTypesTitle: [
                          _getText(ContractType.none),
                          _getText(ContractType.waiting),
                          _getText(ContractType.accepted),
                          _getText(ContractType.canceled),
                          _getText(ContractType.expired)
                        ],
                        contractTypesValue: const [
                          ContractType.none,
                          ContractType.waiting,
                          ContractType.accepted,
                          ContractType.canceled,
                          ContractType.expired
                        ],
                        onSelected: (ContractType? value) {
                          context.read<ContractsBloc>().add(FilterContractsEvent(value));
                        },
                      ),
                      SizedBox(height: 10.v),
                      const SizedBox(
                        width: 200,
                        height: 100,
                      ),
                    ],
                  ),
                );
              }
              if (state is FailureContractsState) {
                return RetryButton(
                  onTap: () {
                    context.read<ContractsBloc>().add(GetContractsEvent());
                  },
                );
              }
              if (state is SuccessContractsState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(title: "نوع العقد"),
                    SizedBox(height: 20.v),
                    Row(
                      children: [
                        Expanded(
                          child: ContractTypeMenuWidget(
                            value: state.option,
                            contractTypesTitle: [
                              _getText(ContractType.none),
                              _getText(ContractType.waiting),
                              _getText(ContractType.accepted),
                              _getText(ContractType.canceled),
                              _getText(ContractType.expired)
                            ],
                            contractTypesValue: const [
                              ContractType.none,
                              ContractType.waiting,
                              ContractType.accepted,
                              ContractType.canceled,
                              ContractType.expired
                            ],
                            onSelected: (ContractType? value) {
                              context.read<ContractsBloc>().add(FilterContractsEvent(value));
                            },
                          ),
                        ),
                        SizedBox(width: 20.0.h,),
                        Expanded(
                          child: MaktabButton(
                            height: 50.0.v,
                            text: 'إنشاء عقد',
                            bold: true,
                            icon: const Icon(
                              Icons.add,
                              color: AppColors.white,
                            ),
                            onPressed: () {
                              context.pushNamed(AppRoutes.addContractScreen);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.v),
                    ContractsWidget(
                      onPressed: (ContractModel selected) {
                        context.read<ContractBloc>().add(GetContractEvent(selected.id));
                        context.pushNamed(AppRoutes.contractScreen);
                      },
                      contracts: state.filteredContracts ?? state.contracts,
                    ),
                  ],
                );
              }
              return const Center(
                child: BodyText(text: "لا يوجد عقود بعد"),
              );
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.pushNamed(AppRoutes.addContractScreen);
      //   },
      //   backgroundColor: AppColors.mintGreen,
      //   child: const Icon(
      //     Icons.add,
      //     color: AppColors.white,
      //   ),
      // ),
    );
  }

  String _getText(ContractType type) {
    switch (type) {
      case ContractType.waiting:
        return 'بأنتظار الموافقة';
      case ContractType.accepted:
        return 'مقبول';
      case ContractType.expired:
        return 'منتهي';
      case ContractType.canceled:
        return 'ملغي';
      case ContractType.none:
        return 'الكل';
    }
  }
}
