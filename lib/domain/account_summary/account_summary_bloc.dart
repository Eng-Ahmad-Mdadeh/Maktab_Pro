import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/account_summary/account_summary_model.dart';
import '../../data/repositories/account_summary_repository.dart';

part 'account_summary_event.dart';

part 'account_summary_state.dart';

class AccountSummaryBloc extends Bloc<AccountSummaryEvent, AccountSummaryState> {
  final AccountSummaryRepository _repository;
  int currentPage = 1;
  AccountSummaryModel? _accountSummaries;
  AccountSummaryModel? _filteredList;

  AccountSummaryBloc(this._repository) : super(AccountSummaryInitial()) {
    on<FetchAccountSummary>((event, emit) async {
      emit(AccountSummaryLoading());
      try {
        final result = await _repository.getAccountSummaries(event.currentPage);
        currentPage = event.currentPage;
        result.fold(
          (l) => emit(AccountSummaryError(l.message)),
          (r) {
            _accountSummaries = r;
            emit(
              AccountSummarySuccess(
                accountSummaries: r,
                filteredAccountSummaries: r,
                currentPage: event.currentPage,
              ),
            );
          },
        );
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(AccountSummaryError(e.toString()));
      }
    });
    on<FetchNextPage>((event, emit) async {
      print("FetchNextPage 1");
      if (event.currentPage < event.lastPage) {
        print("FetchNextPage 2");
        emit(MoreAccountSummaryLoading(_accountSummaries, _filteredList, event.currentPage));
        print("FetchNextPage 3");
        try {
          int cPage = event.currentPage;
          cPage++;
          currentPage = cPage;
          final result = await _repository.getAccountSummaries(cPage);
          print("FetchNextPage 4");

          result.fold(
            (l) => emit(AccountSummaryError(l.message)),
            (r) {
              print("FetchNextPage 5");
              log("--------------------------------");
              log(_accountSummaries?.accountStatement?.data.length.toString() ?? '');
              final List pAccountSummaries = _accountSummaries?.accountStatement?.data ?? [];

              _accountSummaries = _accountSummaries!.copyWith(
                accountStatement: _accountSummaries!.accountStatement!.copyWith(
                  data: [...pAccountSummaries, ...(r.accountStatement?.data??[])]
                )
              );
              log(_accountSummaries?.accountStatement?.data.length.toString() ?? '');
              log("*--------------------------------*");
              emit(AccountSummarySuccess(
                  accountSummaries: _accountSummaries!,
                  filteredAccountSummaries: _filteredList,
                  currentPage: cPage));
            },
          );
        } catch (e, s) {
          log(e.toString());
          log(s.toString());
          print("FetchNextPage 6");
          emit(AccountSummaryError(e.toString()));
        }
      }
    });
    // on<FetchNextPage>(_onFetchNextPage);
    on<FilterAccountSummary>((event, emit) {
      final filteredAccountSummaries = event.query.isNotEmpty ? _accountSummaries?.accountStatement!.data.where(
            (accountSummary) {
          if (event.isPhoneSearch) {
            final withOutCountryCode = accountSummary.phoneTenant!.startsWith('966') ? accountSummary.phoneTenant!.replaceFirst('966', '0') : !accountSummary.phoneTenant!.startsWith('0') ? '0${accountSummary.phoneTenant}' : accountSummary.phoneTenant;
            return accountSummary.phoneTenant!.contains(event.query) || withOutCountryCode!.contains(event.query);
          } else {
            return accountSummary.orderId == event.query;
          }
        },
      ).toList() : _accountSummaries?.accountStatement?.data;
      final s = _accountSummaries?.copyWith(
          accountStatement:
          _accountSummaries?.accountStatement!.copyWith(data: filteredAccountSummaries));

      _filteredList = s;
      log("s.accountStatement?.data.length: ${s?.accountStatement?.data.length}");
      emit(AccountSummarySuccess(accountSummaries: _accountSummaries!, currentPage: currentPage, filteredAccountSummaries: s));
    });
  }
}
