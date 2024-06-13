import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/contract/contract_model.dart';
import '../../../data/repositories/contract_repository.dart';
import 'add/contract_state.dart';

part 'contract_event.dart';

part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractRepository _repository;

  ContractBloc(this._repository) : super(ContractInitial()) {
    on<GetContractEvent>((event, emit) async {
      emit(ContractLoading());
      try {
        final result = await _repository.getContractById(event.id!);
        log("RESULT FROM CONTRACT");
        log(result.toString());
        result.fold(
          (l) => emit(ContractFailure(l.message)),
          (r) {
            emit(ContractSuccess(r));
          },
        );
      } catch (e) {
        // rethrow;
        emit(ContractFailure(e.toString()));
      }
    });
    on<DeleteContractEvent>((event, emit) async {
      try {
        final result = await _repository.deleteContract(event.id!);

        result.fold(
          (l) => emit(ContractFailure(l.message)),
          (r) {
            if (r) {
              add(GetContractEvent(event.id));
            }
          },
        );
      } catch (e) {
        emit(ContractFailure(e.toString()));
      }
    });
    on<CreateContractEvent>((event, emit) async {
      log("CreateContractEvent: ");
      emit(ContractLoading());
      try {
        final result = await _repository.createContract(event.contract!);
        result.fold(
              (l) => emit(ContractFailure(l.message)),
              (r) {
            emit(ContractSuccess(r));
          },
        );
      } catch (e) {
        // rethrow;
        emit(ContractFailure(e.toString()));
      }
    });
  }
}
