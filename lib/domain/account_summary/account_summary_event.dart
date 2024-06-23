part of 'account_summary_bloc.dart';

sealed class AccountSummaryEvent extends Equatable {
  const AccountSummaryEvent();
}

final class FetchAccountSummary extends AccountSummaryEvent{
  final int currentPage;

  const FetchAccountSummary(this.currentPage);
  @override
  List<Object?> get props => [];
}

final class FetchNextPage extends AccountSummaryEvent{
  final int currentPage;
  final int lastPage;

  const FetchNextPage(this.currentPage, this.lastPage);

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
