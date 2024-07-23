import 'package:equatable/equatable.dart';

import '../../../data/models/contract/contract_model.dart';

sealed class ContractsState extends Equatable {}

final class InitialContractsState extends ContractsState {
  @override
  List<Object?> get props => [];
}

final class LoadingContractsState extends ContractsState {
  @override
  List<Object?> get props => [];
}

final class SuccessContractsState extends ContractsState {
  final List<ContractModel> contracts;
  final List<ContractModel>? filteredContracts;
  final ContractType option;

  SuccessContractsState(this.contracts, this.option, [this.filteredContracts]);

  @override
  List<Object?> get props => [...contracts,...filteredContracts??[], option];
}

final class FailureContractsState extends ContractsState {
  final String message;

  FailureContractsState(this.message);

  @override
  List<Object?> get props => [message];
}
