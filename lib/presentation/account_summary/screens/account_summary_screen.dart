import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';

import '../../../domain/account_summary/account_summary_bloc.dart';
import '../widgets/account_summary_details_section.dart';
import '../widgets/office_selection_section.dart';
import '../widgets/unit_selection_section.dart';
import '../../widgets/maktab_app_bar.dart';

class AccountStatementsScreen extends StatefulWidget {
  const AccountStatementsScreen({super.key});

  @override
  State<AccountStatementsScreen> createState() => _AccountStatementsScreenState();
}

class _AccountStatementsScreenState extends State<AccountStatementsScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  int lastPage = 1;
  bool listEndTriggered = false;

  @override
  void didChangeDependencies() {
    context.read<AccountSummaryBloc>().add(const FetchAccountSummary(1));
    _scrollController.addListener(_scrollListener);
    super.didChangeDependencies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      log('Reached the end of the list');
      if (!listEndTriggered) {
        context.read<AccountSummaryBloc>().add(FetchNextPage(currentPage, lastPage));
        listEndTriggered = true;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

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
                Expanded(
                  child: AccountSummaryDetailsSection(
                    _scrollController,
                    onAccountSummarySuccess: (int lPage, int cPage) {
                      lastPage = lPage;
                      currentPage = cPage;
                      print(lastPage);
                      listEndTriggered = false;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
