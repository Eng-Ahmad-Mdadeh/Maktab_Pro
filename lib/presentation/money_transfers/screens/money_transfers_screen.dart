import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';

import '../../resources/app_colors.dart';
import '../../widgets/maktab_app_bar.dart';
import '../widgets/transfer_money_card.dart';

class MoneyTransfersScreen extends StatefulWidget {
  const MoneyTransfersScreen({super.key});

  @override
  State<MoneyTransfersScreen> createState() => _MoneyTransfersScreenState();
}

class _MoneyTransfersScreenState extends State<MoneyTransfersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'الحوالات المالية'),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.v, vertical: 25.v),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaktabTextFormField(
                hintText: 'ابحث برقم الحجز',
                prefix: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: AppColors.gray,
                ),
              ),
              TransferMoneyCard()
            ],
          ),
        ),
      )),
    );
  }
}
