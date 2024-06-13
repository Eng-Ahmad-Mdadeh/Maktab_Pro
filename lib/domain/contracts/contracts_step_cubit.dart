import 'package:flutter_bloc/flutter_bloc.dart';

class ContractStepCubit extends Cubit<int> {
  ContractStepCubit() : super(1);

  void changeStep(int i) {
    emit(i);
  }
}