import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/financial_transactions/receiving_method_model.dart';
import 'package:maktab_lessor/domain/receiving_method/receiving_method_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_drop_down_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';
import 'package:maktab_lessor/presentation/widgets/shimmer_effect.dart';

class BankForm extends StatefulWidget {
  const BankForm({super.key, this.editingMode = false});

  final bool editingMode;

  @override
  State<BankForm> createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  late TextEditingController _accountOwnerController;
  late TextEditingController _ibanNumberController;
  final GlobalKey<FormState> _bankFormKey = GlobalKey<FormState>();
  late ReceivingMethod? receivingMethod;

  @override
  void initState() {
    receivingMethod =
        BlocProvider.of<ReceivingMethodBloc>(context).state.receivingMethod;
    _accountOwnerController =
        TextEditingController(text: receivingMethod?.accountOwnerName ?? '');
    _ibanNumberController =
        TextEditingController(text: receivingMethod?.ibanNumber ?? '');
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
          MaktabSnackbar.showSuccess(context, 'تم حفظ بيانات البنك');
        } else if (state.editReceivingMoneyMethodState ==
            FinancialTransactionsApiState.failure) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, 'فشل حفظ بيانات البنك');
        }
      },
      child: Form(
        key: _bankFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'اختر البنك'),
            SizedBox(height: 10.v),
            BlocBuilder<ReceivingMethodBloc, ReceivingMethodState>(
              builder: (context, state) {
                return ShimmerEffect(
                  isLoading: state.bankAccounts.isEmpty,
                  child: MaktabDropDownFormField(
                    initialValue: receivingMethod != null
                        ? receivingMethod!.bankName
                        : '',
                    items: state.bankAccounts
                        .map((bankAccount) => bankAccount.arTitle)
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'الرجاء اختيار بنك';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context
                          .read<ReceivingMethodBloc>()
                          .add(SetBankNameEvent(value!));
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 30.v),
            MaktabTextFormField(
              title: 'اسم صاحب الحساب',
              hintText: 'ادخل اسم صاحب الحساب',
              controller: _accountOwnerController,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى ادخال اسم صاحب الحساب';
                }
                return null;
              },
            ),
            SizedBox(height: 30.v),
            MaktabTextFormField(
              title: 'رقم الحساب المصرفي',
              hintText: 'أدخل رقم الآيبان',
              controller: _ibanNumberController,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(34),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى ادخال رقم الآيبان';
                } else if (value.length < 5 || value.length > 34) {
                  return 'الرجاء ادخال رقم آيبان صالح';
                }
                return null;
              },
            ),
            SizedBox(height: 30.v),
            MaktabButton(
              text: widget.editingMode ? 'تعديل' : 'إضافة',
              onPressed: () {
                if (_bankFormKey.currentState!.validate()) {
                  context.read<ReceivingMethodBloc>().add(SetBankMethodEvent(
                      _accountOwnerController.text,
                      _ibanNumberController.text));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
