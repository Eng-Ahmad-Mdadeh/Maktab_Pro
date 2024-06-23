part of 'evaluation_bloc.dart';

sealed class EvaluationEvent extends Equatable {
  const EvaluationEvent();
}

final class GetEvaluationsEvent extends EvaluationEvent{
  @override
  List<Object?> get props => [];
}