// ignore_for_file: depend_on_referenced_packages


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/extension/num_extension.dart';
import 'package:maktab_lessor/core/extension/string_extention.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/section_title.dart';

import '../../../domain/account_summary/account_summary_bloc.dart';
import '../../resources/app_colors.dart';

class AccountSummaryHeader extends StatelessWidget {
  const AccountSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSummaryBloc, AccountSummaryState>(
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.h, vertical: 7.0.v),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: 'الإجمالي:'),
                    SectionTitle(title: 'الباقي:'),
                    SectionTitle(title: 'عمولة مكتب:'),
                  ],
                ),
                SizedBox(
                  width: 10.0.adaptSize,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      title: (state is AccountSummarySuccess) ? state.accountSummaries.sumPaid?.toCurrency() ?? '' : '0',
                      textColor: AppColors.mintGreen,
                    ),
                    SectionTitle(
                      title: (state is AccountSummarySuccess) ? state.accountSummaries.sumRemaining?.toStringAsFixedWithCheck(2) ?? '' : '0',
                      textColor: AppColors.cherryRed,
                    ),
                    SectionTitle(
                      title: (state is AccountSummarySuccess) ? state.accountSummaries.sumCommissionValue?.toCurrency() ?? '' : '0',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
