import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/presentation/receiving_method/widgets/receiving_method_option.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';

class ReceivingMethodOptions extends StatelessWidget {
  const ReceivingMethodOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceivingMethodBloc, ReceivingMethodState>(
      listener: (context, state) {
        log(state.toString());
        if (state.selectedReceivingMoneyMethod == ReceivingMoneyMethods.bank &&
            state.bankAccounts.isEmpty) {
          context.read<ReceivingMethodBloc>().add(GetBankAccountsEvent());
        }
        if (state.selectedReceivingMoneyMethod == ReceivingMoneyMethods.bank) {
          context.push(AppRoutes.bankPaymentScreen);
        } else if (state.selectedReceivingMoneyMethod ==
            ReceivingMoneyMethods.stc) {
          context.pushNamed(AppRoutes.stcPayPolicyScreen);
        }
        if (state.deleteReceivingMoneyMethodState ==
            FinancialTransactionsApiState.loading) {
          context.pop();
          LoadingDialog.show(context);
        } else if (state.deleteReceivingMoneyMethodState ==
            FinancialTransactionsApiState.success) {
          context.pop();
          MaktabSnackbar.showSuccess(context, 'تم الحذف بنجاح');
        } else if (state.deleteReceivingMoneyMethodState ==
            FinancialTransactionsApiState.failure) {
          context.pop();
          MaktabSnackbar.showSuccess(context, 'فشل الحذف');
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            if (state.receivingMethod != null &&
                    state.receivingMoneyMethod ==
                        ReceivingMoneyMethods.bankconfirmed ||
                state.receivingMoneyMethod == ReceivingMoneyMethods.none)
              ReceivingMethodOption(
                title: 'تحويل بنكي',
                value: ReceivingMoneyMethods.bankconfirmed,
                groupValue: state.receivingMoneyMethod,
                selectedOnChanged: (value) {
                  context.read<ReceivingMethodBloc>().add(
                      ChooseReceivingMoneyMethodEvent(
                          ReceivingMoneyMethods.bank));
                },
              ),
            if (state.receivingMethod != null &&
                    state.receivingMoneyMethod ==
                        ReceivingMoneyMethods.stcconfirmed ||
                state.receivingMoneyMethod == ReceivingMoneyMethods.none)
              ReceivingMethodOption(
                title: 'STC Pay',
                value: ReceivingMoneyMethods.stcconfirmed,
                groupValue: state.receivingMoneyMethod,
                selectedOnChanged: (value) {
                  context.read<ReceivingMethodBloc>().add(
                      ChooseReceivingMoneyMethodEvent(
                          ReceivingMoneyMethods.stc));
                },
              ),
          ],
        );
      },
    );
  }
}
