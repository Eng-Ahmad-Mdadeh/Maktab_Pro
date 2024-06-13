import 'package:flutter/material.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../widgets/account_summary_details_section.dart';
import '../widgets/office_selection_section.dart';
import '../widgets/unit_selection_section.dart';
import '../../widgets/maktab_app_bar.dart';

class AccountStatementsScreen extends StatelessWidget {
  const AccountStatementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'ملخص الحسابات'),
      body: SafeArea(
        child: SizedBox(
          width: SizeHelper.width,
          child: Padding(
            padding: EdgeInsets.all(20.0.adaptSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const AccountSummaryHeader(),
                // SizedBox(height: 20.v),
                const OfficeSelectionSection(),
                SizedBox(height: 20.v),
                const UnitSelectionSection(),
                SizedBox(height: 40.v),
                const Expanded(child: AccountSummaryDetailsSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
