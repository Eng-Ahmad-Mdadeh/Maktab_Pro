part of 'contract_models_bloc.dart';

sealed class ContractModelsEvent extends Equatable {
  const ContractModelsEvent();
}

final class GetContractsModels extends ContractModelsEvent {
  @override
  List<Object?> get props => [];
}

final class DeleteContractModels extends GetContractsModels {
  final String id;

  DeleteContractModels(this.id);

  @override
  List<Object?> get props => [];
}