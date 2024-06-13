part of 'contract_model_bloc.dart';

sealed class ContractModelState extends Equatable {
  const ContractModelState();
}

final class ContractModelInitial extends ContractModelState {
  @override
  List<Object> get props => [];
}

final class ContractModelLoading extends ContractModelState {
  @override
  List<Object> get props => [];
}

final class ContractModelSuccess extends ContractModelState {
  final ContractModelModel contractModel;
  const ContractModelSuccess(this.contractModel);

  @override
  List<Object> get props => [];
}

final class ContractModelFailure extends ContractModelState {
  final String message;
  const ContractModelFailure(this.message);

  @override
  List<Object> get props => [];
}