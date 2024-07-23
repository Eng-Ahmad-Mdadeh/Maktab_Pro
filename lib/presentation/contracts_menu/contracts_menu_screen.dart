import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_navigation_item.dart';

import '../../domain/contract_models/contract_models_bloc.dart';
import '../../domain/contracts/contracts_bloc.dart';
import '../../domain/contracts/contracts_event.dart';

class ContractsMenuScreen extends StatelessWidget {
  const ContractsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'العقود'),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaktabNavigationItemItem(
              title: 'نماذج العقود',
              onTap: () {
                context.read<ContractModelsBloc>().add(GetContractsModels());
                return context.pushNamed(AppRoutes.contractsModelsScreen);
              },
            ),
            MaktabNavigationItemItem(
              title: 'عقود التأجير',
              onTap: () {
                context.read<ContractsBloc>().add(GetContractsEvent());
                context.pushNamed(AppRoutes.contractsScreen);
              },
            ),
          ],
        ),
      )),
    );
  }
}
