// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/presentation/invoices_and_statements/widgets/monthly_account_statement_box.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';
import 'package:maktab/presentation/widgets/page_title.dart';

class InvoicesAndStatementsScreen extends StatefulWidget {
  const InvoicesAndStatementsScreen({super.key});

  @override
  State<InvoicesAndStatementsScreen> createState() =>
      _InvoicesAndStatementsScreenState();
}

class _InvoicesAndStatementsScreenState
    extends State<InvoicesAndStatementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'الفواتير وكشوف الحساب'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageTitle(title: "اخر الطلبات"),
              SizedBox(height: 30.v),
              MonthlyAccountStatementBox(
                title: 'كشوف حساب شهر ديسمبر',
                onTap: () =>
                    context.pushNamed(AppRoutes.monthlyAccountStatementScreen),
              ),
              SizedBox(height: 15.v),
              MonthlyAccountStatementBox(
                title: 'كشوف حساب شهر نوفمبر',
                onTap: () {},
              ),
              SizedBox(height: 15.v),
              MonthlyAccountStatementBox(
                title: 'كشوف حساب شهر أكتوبر',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
