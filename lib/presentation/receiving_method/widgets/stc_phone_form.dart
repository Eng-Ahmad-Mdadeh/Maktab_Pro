import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/financial_transactions/receiving_method_model.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/phone_text_field.dart';

class StcPhoneForm extends StatefulWidget {
  const StcPhoneForm({super.key});

  @override
  State<StcPhoneForm> createState() => _StcPhoneFormState();
}

class _StcPhoneFormState extends State<StcPhoneForm> {
  late TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ReceivingMethod? receivingMethod =
        BlocProvider.of<ReceivingMethodBloc>(context).state.receivingMethod;
    _phoneController =
        TextEditingController(text: receivingMethod?.mobile ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceivingMethodBloc, ReceivingMethodState>(
      listener: (context, state) {
        if (state.editReceivingMoneyMethodState ==
            FinancialTransactionsApiState.loading) {
          LoadingDialog.show(context);
        } else if (state.editReceivingMoneyMethodState ==
            FinancialTransactionsApiState.success) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showSuccess(context, 'تم تفعيل رقم الجوال');
        } else if (state.editReceivingMoneyMethodState ==
            FinancialTransactionsApiState.failure) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, 'فشل تفعيل رقم الجوال');
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            PhoneTextfield(controller: _phoneController),
            SizedBox(height: 30.v),
            MaktabButton(
              text: 'فعل رقم الجوال',
              onPressed: () {
                context
                    .read<ReceivingMethodBloc>()
                    .add(SetSTCMethodEvent(_phoneController.text));
              },
            )
          ],
        ),
      ),
    ).animate().fade();
  }
}
