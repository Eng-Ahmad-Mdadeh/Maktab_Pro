// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/data/models/financial_transactions/bank_account.dart';
import 'package:maktab/data/models/financial_transactions/receiving_method_model.dart';
import 'package:maktab/data/repositories/financial_transactions_repository.dart';

part 'receiving_method_event.dart';
part 'receiving_method_state.dart';

class ReceivingMethodBloc
    extends Bloc<ReceivingMethodEvent, ReceivingMethodState> {
  final FinancialTransactionsRepository _repository;
  List<BankAccount> bankAccounts = [];

  ReceivingMethodBloc({required FinancialTransactionsRepository repository})
      : _repository = repository,
        super(ReceivingMethodState()) {
    on<ChooseReceivingMoneyMethodEvent>((event, emit) async {
      log(state.receivingMethod.toString());
      emit(state.copyWith(
          selectedReceivingMoneyMethod: ReceivingMoneyMethods.none));
      if (state.receivingMethod == null) {
        emit(state.copyWith(
          getReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
          editReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
          deleteReceivingMoneyMethodState:
              FinancialTransactionsApiState.initial,
          receivingMoneyMethod: ReceivingMoneyMethods.none,
          selectedReceivingMoneyMethod: event.method,
          acceptStcPayPolicy: false,
        ));
      }
    });
    on<ToggleStcPayPolicyEvent>((event, emit) {
      bool currentState = state.acceptStcPayPolicy;
      emit(state.copyWith(
        getReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        editReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        deleteReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        selectedReceivingMoneyMethod: ReceivingMoneyMethods.confirmstc,
        acceptStcPayPolicy: !currentState,
      ));
    });
    on<GetReceivingMoneyMethodEvent>((event, emit) async {
      emit(state.copyWith(
        getReceivingMoneyMethodState: FinancialTransactionsApiState.loading,
        editReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        deleteReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
      ));
      try {
        var result = await _repository.getReceiveMoneyMethod();
        result.fold(
          (failure) => emit(state.copyWith(
            getReceivingMoneyMethodState: FinancialTransactionsApiState.failure,
          )),
          (method) {
            log(method.toString());
            emit(
              state.copyWith(
                getReceivingMoneyMethodState:
                    FinancialTransactionsApiState.success,
                receivingMethod: method,
                receivingMoneyMethod: method.type == 'stc'
                    ? ReceivingMoneyMethods.stcconfirmed
                    : ReceivingMoneyMethods.bankconfirmed,
              ),
            );
          },
        );
      } catch (e) {
        emit(state.copyWith(
          getReceivingMoneyMethodState: FinancialTransactionsApiState.failure,
        ));
      }
    });
    on<SetBankNameEvent>((event, emit) {
      emit(state.copyWith(
        getReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        editReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        deleteReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        selectedReceivingMoneyMethod: ReceivingMoneyMethods.none,
        bankName: event.bankName,
      ));
    });
    on<SetBankMethodEvent>((event, emit) async {
      emit(state.copyWith(
        getReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        editReceivingMoneyMethodState: FinancialTransactionsApiState.loading,
        deleteReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
      ));
      try {
        var result = await _repository.setBankMethod(
          bankName: state.bankName,
          accountOwnerName: event.accountOwnerName,
          ibanNumber: event.ibanNumber,
        );
        result.fold(
          (failure) => emit(state.copyWith(
            editReceivingMoneyMethodState:
                FinancialTransactionsApiState.failure,
          )),
          (method) {
            log(method.type);
            emit(
              state.copyWith(
                editReceivingMoneyMethodState:
                    FinancialTransactionsApiState.success,
                receivingMethod: method,
                receivingMoneyMethod: ReceivingMoneyMethods.bankconfirmed,
                selectedReceivingMoneyMethod:
                    ReceivingMoneyMethods.bankconfirmed,
              ),
            );
          },
        );
      } catch (e) {
        emit(state.copyWith(
          editReceivingMoneyMethodState: FinancialTransactionsApiState.failure,
        ));
      }
    });
    on<SetSTCMethodEvent>((event, emit) async {
      emit(state.copyWith(
        getReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        editReceivingMoneyMethodState: FinancialTransactionsApiState.loading,
        deleteReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
      ));
      try {
        var result = await _repository.setSTCMethod(mobile: event.mobile);
        result.fold(
          (failure) => emit(state.copyWith(
            editReceivingMoneyMethodState:
                FinancialTransactionsApiState.failure,
          )),
          (method) {
            log(method.type);
            emit(
              state.copyWith(
                editReceivingMoneyMethodState:
                    FinancialTransactionsApiState.success,
                receivingMethod: method,
                receivingMoneyMethod: ReceivingMoneyMethods.stcconfirmed,
                selectedReceivingMoneyMethod:
                    ReceivingMoneyMethods.stcconfirmed,
              ),
            );
          },
        );
      } catch (e) {
        emit(state.copyWith(
          editReceivingMoneyMethodState: FinancialTransactionsApiState.failure,
        ));
      }
    });
    on<GetBankAccountsEvent>((event, emit) async {
      if (state.bankAccounts.isEmpty) {
        bankAccounts = await getBankAccounts();
        emit(state.copyWith(
            selectedReceivingMoneyMethod: ReceivingMoneyMethods.none,
            bankAccounts: bankAccounts));
      }
    });
    on<ShowEditReceivingMoneyMethodEvent>((event, emit) async {
      emit(state.copyWith(showEditReceivingMoneyMethod: true));
    });
    on<DeleteReceivingMoneyMethodEvent>((event, emit) async {
      emit(state.copyWith(
        getReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        editReceivingMoneyMethodState: FinancialTransactionsApiState.initial,
        deleteReceivingMoneyMethodState: FinancialTransactionsApiState.loading,
      ));
      try {
        var result = await _repository.deleteReceiveMoneyMethod();
        result.fold(
          (failure) => emit(state.copyWith(
            deleteReceivingMoneyMethodState:
                FinancialTransactionsApiState.failure,
          )),
          (method) {
            state.receivingMethod = null;
            emit(
              state.copyWith(
                deleteReceivingMoneyMethodState:
                    FinancialTransactionsApiState.success,
                receivingMoneyMethod: ReceivingMoneyMethods.none,
                selectedReceivingMoneyMethod: ReceivingMoneyMethods.none,
                acceptStcPayPolicy: false,
                bankName: '',
                showEditReceivingMoneyMethod: false,
              ),
            );
          },
        );
      } catch (e) {
        emit(state.copyWith(
          deleteReceivingMoneyMethodState:
              FinancialTransactionsApiState.failure,
        ));
      }
    });
  }

  Future<List<BankAccount>> getBankAccounts() async {
    var result = await _repository.getBankAccounts();
    return result.fold(
      (failure) => [],
      (bankAccounts) => bankAccounts,
    );
  }
}
