import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/retry_button.dart';

import '../../../../../../core/helpers/size_helper.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../data/models/contract/contract_model.dart';
import '../../../../../domain/contracts/contract/contract_bloc.dart';
import '../../../../../domain/contracts/contracts_bloc.dart';
import '../../../../../domain/contracts/contracts_event.dart';
import '../../../../../domain/contracts/contracts_state.dart';
import '../../../../widgets/maktab_app_bar.dart';
import '../../../../widgets/shimmer_effect.dart';
import '../../../../widgets/text/body_text.dart';
import '../../../../widgets/text/section_title.dart';
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
                        value: 'All',
                        contractTypesTitle: [
                          "كل العقود",
                          "جديد",
                          "مجدد",
                          "منتهي",
                        ],
                        contractTypesValue: const ['All', 'New', 'Renewed', 'Finished'],
                        onSelected: (String? value) {
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
                    ContractTypeMenuWidget(
                      value: state.option,
                      contractTypesTitle: const [
                        "كل العقود",
                        "جديد",
                        "مجدد",
                        "منتهي",
                      ],
                      contractTypesValue: const ['All', 'New', 'Renewed', 'Finished'],
                      onSelected: (String? value) {
                        context.read<ContractsBloc>().add(FilterContractsEvent(value));
                      },
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
                child: BodyText("لا يوجد عقود بعد"),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.addContractScreen);
        },
        backgroundColor: AppColors.mintGreen,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
