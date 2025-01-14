import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/office/office_model.dart';
import '../../data/repositories/evaluation_repository.dart';

part 'evaluation_event.dart';

part 'evaluation_state.dart';

class EvaluationBloc extends Bloc<EvaluationEvent, EvaluationState> {
  final EvaluationRepository _repository;

  EvaluationBloc(this._repository) : super(EvaluationInitial()) {
    on<GetEvaluationsEvent>((event, emit) async {
      emit(EvaluationLoading());
      try {
        final result = await _repository.getEvaluations();
        result.fold(
          (l) => emit(EvaluationFailure(l.message)),
          (r) => emit(EvaluationSuccess(r)),
        );
      } catch (e, s) {
        log(e.toString());
        log(s.toString());
        emit(EvaluationFailure(e.toString()));
      }
    });
  }
}
