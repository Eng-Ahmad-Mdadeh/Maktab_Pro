part of 'account_summary_bloc.dart';

sealed class AccountSummaryState extends Equatable {
  const AccountSummaryState();

  @override
  List<Object?> get props => [];
}

class AccountSummaryInitial extends AccountSummaryState {}

class AccountSummaryLoading extends AccountSummaryState {}

class MoreAccountSummaryLoading extends AccountSummaryState {
  final AccountSummaryModel? accountSummaries;
  final AccountSummaryModel? filteredAccountSummaries;
  final int currentPage;

  const MoreAccountSummaryLoading(this.accountSummaries, this.filteredAccountSummaries, this.currentPage);
}

class AccountSummarySuccess extends AccountSummaryState {
  final AccountSummaryModel accountSummaries;
  final AccountSummaryModel? filteredAccountSummaries;
  final int currentPage;

  const AccountSummarySuccess({
    required this.accountSummaries,
    this.filteredAccountSummaries,
    required this.currentPage,
  });

  AccountSummarySuccess copyWith({
    AccountSummaryModel? accountSummaries,
    AccountSummaryModel? filteredAccountSummaries,
    int? currentPage,
  }) {
    return AccountSummarySuccess(
      accountSummaries: accountSummaries ?? this.accountSummaries,
      filteredAccountSummaries: filteredAccountSummaries ?? this.filteredAccountSummaries,
      currentPage: currentPage ?? this.currentPage,
      // hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [accountSummaries, filteredAccountSummaries, currentPage];
}

class AccountSummaryError extends AccountSummaryState {
  final String message;

  const AccountSummaryError(this.message);

  @override
  List<Object> get props => [message];
}
