part of 'account_summary_bloc.dart';

sealed class AccountSummaryState extends Equatable {
  const AccountSummaryState();

  @override
  List<Object> get props => [];
}

class AccountSummaryInitial extends AccountSummaryState {}

class AccountSummaryLoading extends AccountSummaryState {}

class AccountSummarySuccess extends AccountSummaryState {
  final AccountSummaryModel accountSummaries;
  final AccountSummaryModel filteredAccountSummaries;
  // final bool hasReachedMax;

  const AccountSummarySuccess({
    required this.accountSummaries,
    required this.filteredAccountSummaries,
    // this.hasReachedMax = false,
  });

  AccountSummarySuccess copyWith({
    AccountSummaryModel? accountSummaries,
    AccountSummaryModel? filteredAccountSummaries,
    // bool? hasReachedMax,
  }) {
    return AccountSummarySuccess(
      accountSummaries: accountSummaries ?? this.accountSummaries,
      filteredAccountSummaries: filteredAccountSummaries ?? this.filteredAccountSummaries,
      // hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [accountSummaries, filteredAccountSummaries/*, hasReachedMax*/];
}

class AccountSummaryError extends AccountSummaryState {
  final String message;

  const AccountSummaryError(this.message);

  @override
  List<Object> get props => [message];
}
