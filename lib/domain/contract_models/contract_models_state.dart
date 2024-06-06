part of 'contract_models_bloc.dart';

sealed class ContractModelsState extends Equatable {
  const ContractModelsState();
}

final class ContractModelsInitial extends ContractModelsState {
  @override
  List<Object> get props => [];
}

final class ContractModelsLoading extends ContractModelsState {
  @override
  List<Object> get props => [];
}

final class ContractModelsSuccess extends ContractModelsState {
  final List<ContractModelModel> contractModels;
  const ContractModelsSuccess(this.contractModels);

  @override
  List<Object> get props => [];
}

final class ContractModelsFailure extends ContractModelsState {
  final String message;

  const ContractModelsFailure(this.message);

  @override
  List<Object> get props => [];
}
