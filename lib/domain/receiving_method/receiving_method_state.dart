
part of 'receiving_method_bloc.dart';

class ReceivingMethodState extends Equatable {
  final ReceivingMoneyMethods receivingMoneyMethod;
  final ReceivingMoneyMethods selectedReceivingMoneyMethod;
  final bool acceptStcPayPolicy;
  final FinancialTransactionsApiState getReceivingMoneyMethodState;
  final FinancialTransactionsApiState editReceivingMoneyMethodState;
  final FinancialTransactionsApiState deleteReceivingMoneyMethodState;
  ReceivingMethod? receivingMethod;
  final String bankName;
  final bool showEditReceivingMoneyMethod;
  List<BankAccount> bankAccounts;

  ReceivingMethodState({
    this.receivingMoneyMethod = ReceivingMoneyMethods.none,
    this.selectedReceivingMoneyMethod = ReceivingMoneyMethods.none,
    this.acceptStcPayPolicy = false,
    this.getReceivingMoneyMethodState = FinancialTransactionsApiState.initial,
    this.editReceivingMoneyMethodState = FinancialTransactionsApiState.initial,
    this.deleteReceivingMoneyMethodState =
        FinancialTransactionsApiState.initial,
    this.receivingMethod,
    this.bankName = '',
    this.showEditReceivingMoneyMethod = false,
    this.bankAccounts = const [],
  });

  @override
  List<Object> get props => [
        receivingMoneyMethod,
        selectedReceivingMoneyMethod,
        acceptStcPayPolicy,
        getReceivingMoneyMethodState,
        editReceivingMoneyMethodState,
        bankName,
        deleteReceivingMoneyMethodState,
        showEditReceivingMoneyMethod,
        bankAccounts,
      ];

  ReceivingMethodState copyWith({
    ReceivingMoneyMethods? receivingMoneyMethod,
    ReceivingMoneyMethods? selectedReceivingMoneyMethod,
    bool? acceptStcPayPolicy,
    FinancialTransactionsApiState? getReceivingMoneyMethodState,
    FinancialTransactionsApiState? editReceivingMoneyMethodState,
    ReceivingMethod? receivingMethod,
    String? bankName,
    FinancialTransactionsApiState? deleteReceivingMoneyMethodState,
    bool? showEditReceivingMoneyMethod,
    List<BankAccount>? bankAccounts,
    FinancialTransactionsApiState? getBankAccountsStateState,
  }) {
    return ReceivingMethodState(
      receivingMoneyMethod: receivingMoneyMethod ?? this.receivingMoneyMethod,
      selectedReceivingMoneyMethod:
          selectedReceivingMoneyMethod ?? this.selectedReceivingMoneyMethod,
      acceptStcPayPolicy: acceptStcPayPolicy ?? this.acceptStcPayPolicy,
      getReceivingMoneyMethodState:
          getReceivingMoneyMethodState ?? this.getReceivingMoneyMethodState,
      editReceivingMoneyMethodState:
          editReceivingMoneyMethodState ?? this.editReceivingMoneyMethodState,
      receivingMethod: receivingMethod ?? this.receivingMethod,
      bankName: bankName ?? this.bankName,
      deleteReceivingMoneyMethodState: deleteReceivingMoneyMethodState ??
          this.deleteReceivingMoneyMethodState,
      showEditReceivingMoneyMethod:
          showEditReceivingMoneyMethod ?? this.showEditReceivingMoneyMethod,
      bankAccounts: bankAccounts ?? this.bankAccounts,
    );
  }
}
