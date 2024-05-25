// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/account_summary/widgets/account_summary_details_section.dart';
import 'package:maktab/presentation/account_summary/widgets/account_summary_header.dart';
import 'package:maktab/presentation/account_summary/widgets/office_selection_section.dart';
import 'package:maktab/presentation/account_summary/widgets/unit_selection_section.dart';
import 'package:maktab/presentation/widgets/maktab_app_bar.dart';

class AccountSummaryScreen extends StatefulWidget {
  const AccountSummaryScreen({super.key});

  @override
  State<AccountSummaryScreen> createState() => _AccountSummaryScreenState();
}

class _AccountSummaryScreenState extends State<AccountSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'ملخص الحسابات'),
      body: SafeArea(
        child: SizedBox(
          width: SizeHelper.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AccountSummaryHeader(),
                SizedBox(height: 20.v),
                const OfficeSelectionSection(),
                SizedBox(height: 20.v),
                const UnitSelectionSection(),
                SizedBox(height: 40.v),
                const AccountSummaryDetailsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
