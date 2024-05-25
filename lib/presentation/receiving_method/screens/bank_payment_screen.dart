import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/receiving_method/widgets/bank_form.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class BankPaymentScreen extends StatefulWidget {
  const BankPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BankPaymentScreen> createState() => _BankPaymentScreenState();
}

class _BankPaymentScreenState extends State<BankPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'طريقة استلام المبالغ'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
        child: const SingleChildScrollView(
          child: BankForm(),
        ),
      ),
    );
  }
}
