import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/presentation/receiving_method/widgets/bank_form.dart';
import 'package:maktab_lessor/presentation/receiving_method/widgets/receiving_method_options.dart';
import 'package:maktab_lessor/presentation/receiving_method/widgets/stc_phone_form.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

class ReceivingMethodScreen extends StatefulWidget {
  const ReceivingMethodScreen({super.key});

  @override
  State<ReceivingMethodScreen> createState() => _ReceivingMethodScreenState();
}

class _ReceivingMethodScreenState extends State<ReceivingMethodScreen> {



  @override
  void didChangeDependencies() {
    context.read<ReceivingMethodBloc>().add(GetBankAccountsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'طريقة استلام المبالغ'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'اختر الطريقة المفضلة لديك لاستلام المبالغ المالية',
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 20.v),
              const ReceivingMethodOptions(),
              SizedBox(height: 20.v),
              BlocBuilder<ReceivingMethodBloc, ReceivingMethodState>(
                builder: (context, state) {
                  if (state.showEditReceivingMoneyMethod) {
                    return state.receivingMoneyMethod ==
                            ReceivingMoneyMethods.bankconfirmed
                        ? const BankForm(editingMode: true)
                        : state.receivingMoneyMethod ==
                                ReceivingMoneyMethods.stcconfirmed
                            ? const StcPhoneForm()
                            : const SizedBox.shrink();
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
