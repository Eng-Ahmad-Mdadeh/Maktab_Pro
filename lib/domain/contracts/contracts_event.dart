import 'package:equatable/equatable.dart';

class ContractsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetContractsEvent extends ContractsEvent {}

final class FilterContractsEvent extends ContractsEvent {
  final String? option;

  FilterContractsEvent(this.option);
}


