part of 'evaluation_bloc.dart';

sealed class EvaluationState extends Equatable {
  const EvaluationState();
}

final class EvaluationInitial extends EvaluationState {
  @override
  List<Object> get props => [];
}

final class EvaluationLoading extends EvaluationState {
  @override
  List<Object> get props => [];
}

final class EvaluationSuccess extends EvaluationState {
  final List<Office> evaluations;

  const EvaluationSuccess(this.evaluations);

  @override
  List<Object> get props => [];
}

final class EvaluationFailure extends EvaluationState {
  final String message;
  const EvaluationFailure(this.message);

  @override
  List<Object> get props => [];
}