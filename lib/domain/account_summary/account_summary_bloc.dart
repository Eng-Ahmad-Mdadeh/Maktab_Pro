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
              _accountSummaries = r;
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
      if (state is AccountSummarySuccess) {
        final loadedState = state as AccountSummarySuccess;
        final filteredAccountSummaries = loadedState.accountSummaries.accountStatement!.data.where(
          (accountSummary) {
            if (event.isPhoneSearch) {
              return accountSummary.phoneTenant!.contains(event.query);
            } else {
              return accountSummary.orderId == event.query;
            }
          },
        ).toList();
        final s = loadedState.accountSummaries.copyWith(
            accountStatement:
                loadedState.accountSummaries.accountStatement!.copyWith(data: filteredAccountSummaries));

        _filteredList = s;
        log("s.accountStatement?.data.length: ${s.accountStatement?.data.length}");
        emit(loadedState.copyWith(filteredAccountSummaries: s));
      }
    });
  }

// void _onFetchNextPage(FetchNextPage event, Emitter<AccountSummaryState> emit) async {
//   if (state is AccountSummaryLoaded) {
//     final loadedState = state as AccountSummaryLoaded;
//     if (loadedState.hasReachedMax) return;
//
//     try {
//       final nextPage = (loadedState.accountSummaries.accountStatement!.data.length / _pageSize).ceil() + 1;
//       final result = await _repository.getAccountSummaries(nextPage);
//
//       result.fold(
//             (l) => emit(AccountSummaryError(l.message)),
//             (r) =>
//             emit(r.accountStatement!.data.isEmpty
//                 ? loadedState.copyWith(hasReachedMax: true)
//                 : loadedState.copyWith(
//               accountSummaries: loadedState.accountSummaries.copyWith(
//                 accountStatement: loadedState.accountSummaries.accountStatement!.copyWith(data: List.of(loadedState.accountSummaries.accountStatement!.data)
//                   ..addAll(r.accountStatement!.data),),),
//               filteredAccountSummaries: List.of(loadedState.filteredAccountSummaries)..addAll(accountSummaries),
//             )),
//       );
//     } catch (e) {
//       emit(AccountSummaryError(e.toString()));
//     }
//   }
// }
}
