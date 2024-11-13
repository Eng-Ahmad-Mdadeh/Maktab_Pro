import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/data/models/contract/contract_model_model.dart';

import '../../../data/repositories/contract_model_repository.dart';

part 'contract_model_event.dart';

part 'contract_model_state.dart';

class ContractModelBloc extends Bloc<ContractModelEvent, ContractModelState> {
  final ContractModelRepository _repository;

  ContractModelBloc(this._repository) : super(ContractModelInitial()) {
    on<GetContractModel>((event, emit) async {
      emit(ContractModelLoading());
      try {
        final result = await _repository.getContractModelById(event.id);
        result.fold(
          (l) => emit(ContractModelFailure(l.message)),
          (r) => emit(ContractModelSuccess(r)),
        );
      } catch (e) {
        emit(ContractModelFailure(e.toString()));
      }
    });
    on<CreateContractModels>((event, emit) async {
      emit(ContractModelLoading());
      try {
        final result = await _repository.createContractModel(
          name: event.name,
          description: event.description,
          content: event.contentContractModel,
          status: event.status,
        );
        result.fold(
          (l) => emit(ContractModelFailure(l.message)),
          (r) => emit(ContractModelSuccess(r)),
        );
      } catch (e) {
        emit(ContractModelFailure(e.toString()));
      }
    });
    on<EditContractModels>((event, emit) async {
      emit(ContractModelLoading());
      try {
        final result = await _repository.updateContractModel(
          id: event.id,
          name: event.name,
          description: event.description,
          content: event.contentContractModel,
          status: event.status,
        );
        result.fold(
          (l) => emit(ContractModelFailure(l.message)),
          (r) => emit(ContractModelSuccess(r)),
        );
      } catch (e) {
        emit(ContractModelFailure(e.toString()));
      }
    });
  }
}
