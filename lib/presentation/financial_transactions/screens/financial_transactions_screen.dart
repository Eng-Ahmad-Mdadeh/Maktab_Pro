// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab/presentation/widgets/maktab_navigation_item.dart';
import 'package:maktab/presentation/widgets/loading_dialog.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class FinincialTransactionsScreen extends StatefulWidget {
  const FinincialTransactionsScreen({super.key});

  @override
  State<FinincialTransactionsScreen> createState() =>
      _FinincialTransactionsScreenState();
}

class _FinincialTransactionsScreenState
    extends State<FinincialTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceivingMethodBloc, ReceivingMethodState>(
      listener: (context, state) {
        if (state.getReceivingMoneyMethodState ==
            FinancialTransactionsApiState.loading) {
          LoadingDialog.show(context);
        } else if (state.getReceivingMoneyMethodState ==
            FinancialTransactionsApiState.success) {
          LoadingDialog.hide(context);
          context.pushNamed(AppRoutes.receivingMethodScreen);
        } else if (state.getReceivingMoneyMethodState ==
            FinancialTransactionsApiState.failure) {
          LoadingDialog.hide(context);
          context.pushNamed(AppRoutes.receivingMethodScreen);
        }
      },
      child: Scaffold(
        appBar: const MaktabAppBar(title: 'المعاملات المالية'),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 25.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaktabNavigationItemItem(
                  title: 'طريقة استلام المبالغ',
                  onTap: () {
                    if (context
                            .read<ReceivingMethodBloc>()
                            .state
                            .receivingMethod ==
                        null) {
                      context
                          .read<ReceivingMethodBloc>()
                          .add(GetReceivingMoneyMethodEvent());
                    } else {
                      context.pushNamed(AppRoutes.receivingMethodScreen);
                    }
                  },
                ),
                MaktabNavigationItemItem(
                  title: 'الحوالات المالية',
                  onTap: () =>
                      context.pushNamed(AppRoutes.moneyTransfersScreen),
                ),
                MaktabNavigationItemItem(
                  title: 'كشوف الحساب',
                  onTap: () =>
                      context.pushNamed(AppRoutes.invoicesAndStatementsScreen),
                ),
                MaktabNavigationItemItem(
                  title: 'ملخص الحسابات',
                  onTap: () =>
                      context.pushNamed(AppRoutes.accountSummaryScreen),
                ),
                MaktabNavigationItemItem(
                  title: 'توثيق الحساب بالنفاذ الوطني',
                  onTap: () => context
                      .pushNamed(AppRoutes.verifyAccountWithNationalAccess),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
