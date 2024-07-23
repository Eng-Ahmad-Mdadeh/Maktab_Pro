import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../../data/models/order/order_model.dart';
import '../../../../../../../../widgets/maktab_snack_bar.dart';
import '../../../../../../../../../data/repositories/office_repository.dart';
import '../../../../../../../../../domain/contracts/contracts_event.dart';
import '../../../../../../../../../core/services/service_locator.dart';
import '../../../../../../../../../domain/contract_models/contract_models_bloc.dart';
import '../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../domain/contracts/contract/contract_bloc.dart';
import '../../../../../../../../../domain/contracts/contracts_bloc.dart';
import '../../../../../../../../../domain/contracts/contracts_step_cubit.dart';
import '../../../../../../../../../domain/orders/orders_bloc.dart';
import '../../../../../../../../../domain/settings/settings_bloc.dart';
import '../../../../../../../../resources/app_colors.dart';

import '../widgets/contract_pages.dart';
import '../widgets/contracts_buttons.dart';
import '../widgets/steps_widget.dart';

class AddContractScreen extends StatefulWidget {
  final OrderModel? order;

  const AddContractScreen({super.key, this.order});

  @override
  State<AddContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<AddContractScreen> {
  late ContractStepCubit _contractStepCubit;
  late ContractCubit _contractCubit;

  late SearchDataBloc _searchDataBloc;

  @override
  void initState() {
    context.read<OrdersBloc>().add(GetOrdersWithoutPaginationEvent());
    context.read<ContractModelsBloc>().add(GetContractsModels());
    _contractStepCubit = ContractStepCubit();
    _contractCubit = ContractCubit(_contractStepCubit, widget.order);
    _searchDataBloc = SearchDataBloc(locator<OfficeRepository>())..add(GetSearchDataEvent());
    super.initState();
  }

  @override
  void dispose() {
    // _contractModelBloc.close();
    _contractStepCubit.close();
    _contractCubit.close();
    _searchDataBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _contractStepCubit,
        ),
        BlocProvider(
          create: (_) => _contractCubit,
        ),
        // BlocProvider(create: (_) => _contractModelBloc,),
        BlocProvider(
          create: (_) => _searchDataBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.arrow_back_ios),
          ),

          backgroundColor: AppColors.white,
        ),
        body: BlocListener<ContractBloc, ContractState>(
          listener: (context, state) {
            if (state is ContractLoading) {
              MaktabSnackbar.showWarning(context, "جار احفظ العقد");
            }
            if (state is ContractSuccess) {
              MaktabSnackbar.showSuccess(context, "تم الحفظ بنجاح");
              context.read<ContractsBloc>().add(GetContractsEvent());
              context.pop();
            }
            if (state is ContractFailure) {
              MaktabSnackbar.showError(context, state.message);
            }
          },
          child: const Column(
            children: [
              StepsWidget(),
              ContractPages(),
              ContractsButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
