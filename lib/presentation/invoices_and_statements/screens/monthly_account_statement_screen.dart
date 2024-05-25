// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/invoices_and_statements/widgets/statement_balance_section.dart';
import 'package:maktab/presentation/invoices_and_statements/widgets/statement_ending_section.dart';
import 'package:maktab/presentation/invoices_and_statements/widgets/statement_header.dart';
import 'package:maktab/presentation/invoices_and_statements/widgets/statement_total_section.dart';
import 'package:maktab/presentation/invoices_and_statements/widgets/statements_table.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class MonthlyAccountStatementScreen extends StatefulWidget {
  const MonthlyAccountStatementScreen({super.key});

  @override
  State<MonthlyAccountStatementScreen> createState() =>
      _MonthlyAccountStatementScreenState();
}

class _MonthlyAccountStatementScreenState
    extends State<MonthlyAccountStatementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'الفواتير وكشوف الحساب'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 25.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StatementHeader(),
              SizedBox(height: 5.v),
              const Divider(color: AppColors.softAsh),
              SizedBox(height: 5.v),
              const StatementBalanceSection(),
              StatementsTable(),
              SizedBox(height: 20.v),
              const StatementEndingSection(),
              SizedBox(height: 30.v),
              const StatementTotalSection(total: '3000'),
            ],
          ),
        ),
      ),
    );
  }
}
