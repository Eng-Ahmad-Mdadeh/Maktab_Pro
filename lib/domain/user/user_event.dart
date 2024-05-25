part of 'user_bloc.dart';

enum UserApiCallState { initial, loading, success, failure, noCall }

enum RequestAssuranceState { request, norequest }

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class GetUserAgreementEvent extends UserEvent {}

final class ToggleAssuranceRequiredEvent extends UserEvent {
  final bool value;

  const ToggleAssuranceRequiredEvent(this.value);
}

final class GetUnitSettingsEvent extends UserEvent {}

final class SetInsurancePriceEvent extends UserEvent {
  final String price;

  const SetInsurancePriceEvent(this.price);
}

final class SetConditionsEvent extends UserEvent {
  final String conditions;

  const SetConditionsEvent(this.conditions);
}

final class SetUnitSettingsEvent extends UserEvent {}
