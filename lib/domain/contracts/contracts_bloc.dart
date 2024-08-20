import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contract/contract_model.dart';
import '../../../data/repositories/contract_repository.dart';
import 'contracts_event.dart';
import 'contracts_state.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  final ContractRepository _repository;

  List<ContractModel> _contracts = [];

  ContractsBloc(this._repository) : super(InitialContractsState()) {
    on<GetContractsEvent>((event, emit) async {
      emit(LoadingContractsState());
      try {
        final result = await _repository.getContract();

        result.fold(
          (l) => emit(FailureContractsState(l.message)),
          (r) {
            _contracts = r;
            emit(SuccessContractsState(r, ContractType.none));
          },
        );
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(FailureContractsState(e.toString()));
      }
    });

    on<FilterContractsEvent>((event, emit) {
      emit(SuccessContractsState(
          _contracts, event.option ?? ContractType.none, event.option == ContractType.none ? _contracts : _contracts.where((e) {
            return e.customContractType == event.option;
          }).toList()));
    });
  }
}
// viewed ads on map
// stared ad on map yellow
