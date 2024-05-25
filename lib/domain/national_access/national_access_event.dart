// ignore_for_file: must_be_immutable

part of 'national_access_bloc.dart';

enum AccountTypes { identity, residence }

enum NationalAccessApiState { initial, loading, success, failure }

sealed class NationalAccessEvent extends Equatable {
  const NationalAccessEvent();

  @override
  List<Object> get props => [];
}

class SelectAccountTypeEvent extends NationalAccessEvent {
  AccountTypes type;

  SelectAccountTypeEvent(this.type);
}

class VerifyNationalAccessEvent extends NationalAccessEvent {
  String id;

  VerifyNationalAccessEvent(this.id);
}
