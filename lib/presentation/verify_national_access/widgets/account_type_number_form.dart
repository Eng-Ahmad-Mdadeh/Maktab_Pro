import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/domain/national_access/national_access_bloc.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';

class AccountTypeNumberForm extends StatefulWidget {
  const AccountTypeNumberForm({super.key, required this.type});

  final AccountTypes type;

  @override
  State<AccountTypeNumberForm> createState() => _AccountTypeNumberFormState();
}

class _AccountTypeNumberFormState extends State<AccountTypeNumberForm> {
  late TextEditingController accountTypeNumberController;
  late GlobalKey<FormState> _numberFormKey;

  @override
  void initState() {
    accountTypeNumberController = TextEditingController();
    _numberFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _numberFormKey,
      child: Column(
        children: [
          widget.type == AccountTypes.identity
              ? MaktabTextFormField(
                  controller: accountTypeNumberController,
                  title: 'رقم الهوية الوطنية',
                  hintText: 'أدخل رقم الهوية الوطنية',
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجى ادخال رقم الهوية';
                    }
                    if (value.length < 9) {
                      return 'يرجى ادخال رقم هوية صالح';
                    }
                    return null;
                  },
                )
              : MaktabTextFormField(
                  controller: accountTypeNumberController,
                  title: 'رقم الإقامة',
                  hintText: 'أدخل رقم الإقامة',
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجى ادخال رقم الإقامة';
                    }
                    if (value.length < 12) {
                      return 'يرجى ادخال رقم إقامة صالح';
                    }
                    return null;
                  },
                ),
          SizedBox(height: 20.v),
          MaktabButton(
            onPressed: () {
              if (_numberFormKey.currentState!.validate()) {
                context.read<NationalAccessBloc>().add(
                    VerifyNationalAccessEvent(
                        accountTypeNumberController.text));
              }
            },
            height: 70.v,
            text: 'التحقق',
          ),
        ],
      ),
    );
  }
}
