
part of 'receiving_method_bloc.dart';

enum ReceivingMoneyMethods {
  none,
  bank,
  bankconfirmed,
  stc,
  confirmstc,
  stcconfirmed
}

enum FinancialTransactionsApiState { initial, loading, success, failure }

sealed class ReceivingMethodEvent extends Equatable {
  const ReceivingMethodEvent();

  @override
  List<Object> get props => [];
}

class ChooseReceivingMoneyMethodEvent extends ReceivingMethodEvent {
  ReceivingMoneyMethods method;

  ChooseReceivingMoneyMethodEvent(this.method);
}

class ToggleStcPayPolicyEvent extends ReceivingMethodEvent {}

class GetReceivingMoneyMethodEvent extends ReceivingMethodEvent {}

class SetBankNameEvent extends ReceivingMethodEvent {
  String bankName;

  SetBankNameEvent(this.bankName);
}

class SetBankMethodEvent extends ReceivingMethodEvent {
  String accountOwnerName;
  String ibanNumber;

  SetBankMethodEvent(this.accountOwnerName, this.ibanNumber);
}

class SetSTCMethodEvent extends ReceivingMethodEvent {
  String mobile;

  SetSTCMethodEvent(this.mobile);
}

class ShowEditReceivingMoneyMethodEvent extends ReceivingMethodEvent {}

class DeleteReceivingMoneyMethodEvent extends ReceivingMethodEvent {}

class GetBankAccountsEvent extends ReceivingMethodEvent {}

class CheckReceivingMoneyMethodEvent extends ReceivingMethodEvent {}
