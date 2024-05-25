part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.agreement,
    this.userAgreementApiCallState = UserApiCallState.initial,
    this.message = '',
    this.isInsuranceRequired = false,
    this.unitSettings,
    this.getUnitSettingsApiCallState = UserApiCallState.initial,
    this.insurancePrice = '',
    this.conditions = '',
    this.updateUnitSettingsApiCallState = UserApiCallState.initial,
  });

  final UserAgreement? agreement;
  final UserApiCallState userAgreementApiCallState;
  final String message;
  final bool isInsuranceRequired;
  final UnitSettings? unitSettings;
  final UserApiCallState getUnitSettingsApiCallState;
  final String insurancePrice;
  final String conditions;
  final UserApiCallState updateUnitSettingsApiCallState;

  @override
  List<Object?> get props => [
        agreement,
        userAgreementApiCallState,
        message,
        isInsuranceRequired,
        unitSettings,
        getUnitSettingsApiCallState,
        insurancePrice,
        conditions,
        updateUnitSettingsApiCallState,
      ];

  UserState copyWith({
    UserAgreement? agreement,
    UserApiCallState? userAgreementApiCallState,
    String? message,
    bool? isInsuranceRequired,
    UnitSettings? unitSettings,
    UserApiCallState? getUnitSettingsApiCallState,
    String? insurancePrice,
    String? conditions,
    UserApiCallState? updateUnitSettingsApiCallState,
  }) {
    return UserState(
      agreement: agreement ?? this.agreement,
      userAgreementApiCallState:
          userAgreementApiCallState ?? this.userAgreementApiCallState,
      message: message ?? this.message,
      isInsuranceRequired: isInsuranceRequired ?? this.isInsuranceRequired,
      unitSettings: unitSettings ?? this.unitSettings,
      getUnitSettingsApiCallState:
          getUnitSettingsApiCallState ?? this.getUnitSettingsApiCallState,
      insurancePrice: insurancePrice ?? this.insurancePrice,
      conditions: conditions ?? this.conditions,
      updateUnitSettingsApiCallState:
          updateUnitSettingsApiCallState ?? this.updateUnitSettingsApiCallState,
    );
  }
}
