part of 'contract_bloc.dart';

sealed class ContractEvent extends Equatable {
  const ContractEvent();
}

final class GetContractEvent extends ContractEvent {
  final int? id;

  const GetContractEvent(this.id);

  @override
  List<Object?> get props => [];
}

final class DeleteContractEvent extends ContractEvent {
  final int? id;

  const DeleteContractEvent(this.id);

  @override
  List<Object?> get props => [];
}

final class UpdateContractEvent extends ContractEvent {
  final ContractModel? contract;

  const UpdateContractEvent(this.contract);

  @override
  List<Object?> get props => [];
}

final class CreateContractEvent extends ContractEvent {
  final ContractEntity? contract;

  const CreateContractEvent(this.contract);

  @override
  List<Object?> get props => [];
}