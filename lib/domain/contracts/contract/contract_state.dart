part of 'contract_bloc.dart';

sealed class ContractState extends Equatable {
  const ContractState();
}

final class ContractInitial extends ContractState {
  @override
  List<Object> get props => [];
}

final class ContractLoading extends ContractState {
  @override
  List<Object?> get props => [];
}

final class ContractSuccess extends ContractState {
  final ContractModel contract;

  const ContractSuccess(this.contract);

  @override
  List<Object?> get props => [contract];
}

final class ContractFailure extends ContractState {
  final String message;

  const ContractFailure(this.message);

  @override
  List<Object?> get props => [message];
}