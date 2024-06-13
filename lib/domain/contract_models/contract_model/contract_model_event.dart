part of 'contract_model_bloc.dart';

sealed class ContractModelEvent extends Equatable {
  const ContractModelEvent();
}

final class GetContractModel extends ContractModelEvent{
  final String id;
  const GetContractModel(this.id);

  @override
  List<Object?> get props => [];

}

final class CreateContractModels extends ContractModelEvent {
  final String name;
  final String description;
  final String contentContractModel;
  final String status;

  const CreateContractModels({
    required this.name,
    required this.description,
    required this.contentContractModel,
    required this.status,
  });
  @override
  List<Object?> get props => [];
}

final class EditContractModels extends ContractModelEvent {
  final int id;
  final String name;
  final String description;
  final String contentContractModel;
  final String status;

  const EditContractModels({
    required this.id,
    required this.name,
    required this.description,
    required this.contentContractModel,
    required this.status,
  });

  @override
  List<Object?> get props => [];
}


