import 'package:equatable/equatable.dart';

import '../../data/models/contract/contract_model.dart';

class ContractsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetContractsEvent extends ContractsEvent {}

final class FilterContractsEvent extends ContractsEvent {
  final ContractType? option;

  FilterContractsEvent(this.option);
}


