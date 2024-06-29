import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/widgets/loading_widget.dart';

import '../../../data/models/account_summary/account_summary_model.dart';
import '../../../domain/account_summary/account_summary_bloc.dart';
import '../../widgets/body_text.dart';
import '../../resources/app_colors.dart';
import 'summary_card.dart';

class AccountSummaryDetailsSection extends StatelessWidget {
  final bool noContents;
  final ScrollController? _scrollController;
  final void Function(int, int) onAccountSummarySuccess;

  const AccountSummaryDetailsSection(
    this._scrollController, {
    super.key,
    this.noContents = false,
    required this.onAccountSummarySuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountSummaryBloc, AccountSummaryState>(
      builder: (context, state) {
        if (state is AccountSummaryLoading) return const Center(child: LoadingWidget(1));
        if (state is AccountSummaryError) return Center(child: BodyText(text: state.message));
        if (state is AccountSummarySuccess) {
          onAccountSummarySuccess(state.accountSummaries.accountStatement?.lastPage ?? 1, state.currentPage);
          return AccountSummaryBuilder(
            _scrollController,
            moreOrderLoader: false,
            accountSummaries: state.accountSummaries,
            noContents: noContents,
          );
        }
        if (state is MoreAccountSummaryLoading) {
          return AccountSummaryBuilder(
            _scrollController,
            moreOrderLoader: true,
            accountSummaries: state.accountSummaries!,
            noContents: noContents,
          );
        }
        return const Center(child: BodyText(text: 'لا يوجد بيانات حاليا'));
      },
    );
  }
}

class AccountSummaryBuilder extends StatelessWidget {
  final bool noContents;
  final bool moreOrderLoader;
  final ScrollController? _scrollController;
  final AccountSummaryModel accountSummaries;

  const AccountSummaryBuilder(
    this._scrollController, {
    super.key,
    required this.noContents,
    required this.moreOrderLoader,
    required this.accountSummaries,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // itemCount: state.accountSummaries.accountStatement!.data.length,
      controller: _scrollController,
      itemCount: moreOrderLoader
          ? accountSummaries.accountStatement!.data.length + 1
          : accountSummaries.accountStatement!.data.length,
      itemBuilder: (context, i) {
        if (moreOrderLoader) {
          if (i == accountSummaries.accountStatement!.data.length) {
            return const Center(child: CircularProgressIndicator());
          }
        }
        final data = accountSummaries.accountStatement!.data[i];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.softAsh),
            borderRadius: BorderRadius.circular(7.0.adaptSize),
          ),
          // padding: const EdgeInsets.all(14.0),
          child: SummaryCard(
            data: data,
          ),
        );
      },
    );
  }
}
