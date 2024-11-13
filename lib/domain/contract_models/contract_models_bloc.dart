import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/contract/contract_model_model.dart';
import '../../data/repositories/contract_model_repository.dart';

part 'contract_models_event.dart';

part 'contract_models_state.dart';

class ContractModelsBloc extends Bloc<ContractModelsEvent, ContractModelsState> {
  final ContractModelRepository _repository;

  ContractModelsBloc(this._repository) : super(ContractModelsInitial()) {
    on<GetContractsModels>((event, emit) async {
      emit(ContractModelsLoading());
      try {
        final result = await _repository.getContractModels();

        result.fold(
          (l) => emit(ContractModelsFailure(l.message)),
          (r) => emit(ContractModelsSuccess(r)),
        );
      } catch (e) {
        emit(ContractModelsFailure(e.toString()));
      }
    });

    on<DeleteContractModels>((event, emit) async {
      emit(ContractModelsLoading());
      try {
        final result = await _repository.deleteContractModel(event.id);
        result.fold(
              (l) => emit(ContractModelsFailure(l.message)),
              (r) => add(GetContractsModels()),
        );
      } catch (e) {
        emit(ContractModelsFailure(e.toString()));
      }
    });
  }
}
