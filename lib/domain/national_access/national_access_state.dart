
part of 'national_access_bloc.dart';

class NationalAccessState extends Equatable {
  AccountTypes accountType;
  NationalAccessApiState verifyState;
  String message;

  NationalAccessState({
    this.accountType = AccountTypes.identity,
    this.verifyState = NationalAccessApiState.initial,
    this.message = '',
  });

  @override
  List<Object> get props => [accountType, verifyState, message];

  NationalAccessState copyWith({
    AccountTypes? accountType,
    NationalAccessApiState? verifyState,
    String? message,
  }) {
    return NationalAccessState(
      accountType: accountType ?? this.accountType,
      verifyState: verifyState ?? this.verifyState,
      message: message ?? this.message,
    );
  }
}
