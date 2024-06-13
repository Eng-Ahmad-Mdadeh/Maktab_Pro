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
            emit(SuccessContractsState(r, "All"));
          },
        );
      } catch (e) {
        emit(FailureContractsState(e.toString()));
      }
    });

    on<FilterContractsEvent>((event, emit) {
      emit(SuccessContractsState(
          _contracts, event.option ?? "All", event.option == "All" ? _contracts : _contracts.where((e) => e.contractType == event.option).toList()));
    });
    add(GetContractsEvent());

  }
}
// viewed ads on map
// stared ad on map yellow
