import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/repositories/financial_transactions_repository.dart';
import 'package:maktab_lessor/domain/profile/profile_bloc.dart';

part 'national_access_event.dart';
part 'national_access_state.dart';

class NationalAccessBloc
    extends Bloc<NationalAccessEvent, NationalAccessState> {
  final FinancialTransactionsRepository _repository;
  NationalAccessBloc({required FinancialTransactionsRepository repository})
      : _repository = repository,
        super(NationalAccessState()) {
    on<SelectAccountTypeEvent>((event, emit) {
      emit(state.copyWith(
        accountType: event.type,
        verifyState: NationalAccessApiState.initial,
      ));
    });
    on<VerifyNationalAccessEvent>((event, emit) async {
      emit(state.copyWith(verifyState: NationalAccessApiState.loading));
      dynamic result;
      if (state.accountType == AccountTypes.identity) {
        result = await _repository.verifyNationalID(nationalID: event.id);
      } else {
        result = await _repository.verifyResidenceID(residenceId: event.id);
      }
      result.fold(
            (failure) => emit(state.copyWith(
            verifyState: NationalAccessApiState.failure,
            message: failure.message)),
            (method) {
          emit(state.copyWith(
              verifyState: NationalAccessApiState.success,
              message: 'تم توثيق الحساب'));
          locator<ProfileBloc>().add(GetProfileEvent());
        },
      );
    });
  }
}
