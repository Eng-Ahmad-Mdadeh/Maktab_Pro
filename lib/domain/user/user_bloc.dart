import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab/data/models/office/unit_settings.dart';
import 'package:maktab/data/models/user/user_agreement_model.dart';
import 'package:maktab/data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;
  UserBloc({required UserRepository userRepository})
      : _repository = userRepository,
        super(const UserState()) {
    on<GetUserAgreementEvent>((event, emit) async {
      emit(state.copyWith(
        userAgreementApiCallState: UserApiCallState.loading,
        getUnitSettingsApiCallState: UserApiCallState.initial,
        updateUnitSettingsApiCallState: UserApiCallState.initial,
      ));
      final result = await _repository.getUserAgreement();
      result.fold(
        (failure) => emit(state.copyWith(
            userAgreementApiCallState: UserApiCallState.failure,
            message: failure.message)),
        (agreement) {
          emit(state.copyWith(
            userAgreementApiCallState: UserApiCallState.success,
            agreement: agreement,
          ));
        },
      );
    });
    on<ToggleAssuranceRequiredEvent>((event, emit) async {
      emit(state.copyWith(isInsuranceRequired: event.value));
    });
    on<SetInsurancePriceEvent>((event, emit) async {
      emit(state.copyWith(insurancePrice: event.price));
    });
    on<SetConditionsEvent>((event, emit) async {
      emit(state.copyWith(conditions: event.conditions));
    });
    on<GetUnitSettingsEvent>((event, emit) async {
      emit(state.copyWith(
        getUnitSettingsApiCallState: UserApiCallState.loading,
        updateUnitSettingsApiCallState: UserApiCallState.initial,
        userAgreementApiCallState: UserApiCallState.initial,
      ));
      final result = await _repository.getUnitSettings();
      result.fold(
        (failure) => emit(state.copyWith(
          getUnitSettingsApiCallState: UserApiCallState.failure,
          message: failure.message,
        )),
        (unitSettings) {
          emit(state.copyWith(
            getUnitSettingsApiCallState: UserApiCallState.success,
            isInsuranceRequired:
                unitSettings != null ? unitSettings.isInsuranceRequired : false,
            unitSettings: unitSettings,
          ));
        },
      );
    });
    on<SetUnitSettingsEvent>((event, emit) async {
      if (state.isInsuranceRequired !=
              state.unitSettings!.isInsuranceRequired ||
          state.insurancePrice != state.unitSettings!.price.toString() ||
          state.conditions != state.unitSettings!.text) {
        emit(state.copyWith(
          updateUnitSettingsApiCallState: UserApiCallState.loading,
          getUnitSettingsApiCallState: UserApiCallState.initial,
        ));
        final result = await _repository.setUnitSettings(
          isInsuranceRequired: state.isInsuranceRequired,
          insurancePrice: state.insurancePrice,
          conditions: state.conditions,
        );
        result.fold(
          (failure) => emit(state.copyWith(
            updateUnitSettingsApiCallState: UserApiCallState.failure,
            message: failure.message,
          )),
          (unitSettings) {
            emit(state.copyWith(
              updateUnitSettingsApiCallState: UserApiCallState.success,
              unitSettings: unitSettings,
            ));
          },
        );
      } else {
        emit(state.copyWith(
          updateUnitSettingsApiCallState: UserApiCallState.noCall,
          getUnitSettingsApiCallState: UserApiCallState.initial,
        ));
      }
    });
  }
}
