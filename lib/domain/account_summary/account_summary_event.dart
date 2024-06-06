part of 'account_summary_bloc.dart';

sealed class AccountSummaryEvent extends Equatable {
  const AccountSummaryEvent();
}

final class FetchAccountSummary extends AccountSummaryEvent{
  @override
  List<Object?> get props => [];
}

final class FetchNextPage extends AccountSummaryEvent{
  @override
  List<Object?> get props => [];
}


class FilterAccountSummary extends AccountSummaryEvent {
  final String query;
  final bool isPhoneSearch;

  const FilterAccountSummary(this.query, this.isPhoneSearch);

  @override
  List<Object> get props => [query];
}
